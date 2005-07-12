Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVGLPo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVGLPo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVGLPo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:44:27 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:57628 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261368AbVGLPoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:44:25 -0400
Date: Tue, 12 Jul 2005 17:44:22 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Tom Zanussi <zanussi@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <17107.57046.817407.562018@tut.ibm.com>
Message-ID: <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-579491078-1121183062=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-579491078-1121183062=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jul 2005, Tom Zanussi wrote:

> =?ISO-8859-2?Q?Tomasz_K=B3oczko?= writes:
> > On Mon, 11 Jul 2005, Tom Zanussi wrote:
> >
> > >
> > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> > > logging and buffering capability, which does not currently exist in
> > > the kernel.
> > >
> > > relayfs key features:
> > >
> > > - Extremely efficient high-speed logging/buffering
> >
> > Usualy/for now relayfs is used as base infrastructure for variuos
> > debuging/measuring.
> > IMO storing raw data and transfer them to user space it is wrong way.
> > Why ? Becase i adds very big overhead for memory nad storage.
> > Big .. compare to in situ storing partialy analyzed data in conters
> > and other like it is in DTrace.
> >
>
> But isn't it supposed to be a good thing to keep analysis out of the
> kernel if possible?

As long as you try for example measure (?) .. not.

> And many things can't be aggregated, such as the detailed sequence of 
> events in a trace.

DTrace real examples shows something completly diffret.
MANY things (if not ~almost all) can be kept only in aggregated form 
during experiments.

> Anyway, it doesn't have to be
> an 'all or nothing' thing.  For some applications it may make sense to
> do some amount of filtering and aggregation in the kernel.  AFAICS
> DTrace takes this to the extreme and does everything in the kernel,
> and IIRC it can't easily be made to general system tracing along the
> lines of LTT, for instance.

Try measure number of dysk I/O operation without touching storage for 
store raw data. What you need ? only one counter (few bytes) instead of huge 
amount of memeory for buffer and store logs. Try measure something like
scheduler with possible small system distruption.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-579491078-1121183062=:6919--
