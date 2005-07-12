Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVGLOBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVGLOBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGLOBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:01:51 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:28287 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261434AbVGLOBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:01:19 -0400
Date: Tue, 12 Jul 2005 16:01:16 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Tom Zanussi <zanussi@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <17107.6290.734560.231978@tut.ibm.com>
Message-ID: <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-908360741-1121176876=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-908360741-1121176876=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 11 Jul 2005, Tom Zanussi wrote:

>
> Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> logging and buffering capability, which does not currently exist in
> the kernel.
>
> relayfs key features:
>
> - Extremely efficient high-speed logging/buffering

Usualy/for now relayfs is used as base infrastructure for variuos
debuging/measuring.
IMO storing raw data and transfer them to user space it is wrong way.
Why ? Becase i adds very big overhead for memory nad storage.
Big .. compare to in situ storing partialy analyzed data in conters
and other like it is in DTrace.

IMO much better will be add base/template set of functions for use in 
KProbes probes which will come with KProbes code as base tool set. It will 
allow cut transfered data size from megabites/gigabyutes to hundret 
bytes/kilo bytes, make debuging/measuring more smooth without additional 
latency for transfer data outside kernel space.

It will be good not reinvent wheel in wrong way if in working implemtation 
like DTrace it work more than well.

Yes, maybe it will be good have something like relayfs for some other 
tasks but for debuging/measuring better will be IMO use other way which 
will not use this technik.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-908360741-1121176876=:6919--
