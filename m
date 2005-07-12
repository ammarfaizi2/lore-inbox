Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVGLRDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVGLRDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGLRDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:03:06 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:42366 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261587AbVGLRBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:01:44 -0400
Date: Tue, 12 Jul 2005 19:01:42 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Tom Zanussi <zanussi@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <17107.61271.924455.965538@tut.ibm.com>
Message-ID: <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
 <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1183889908-1121187702=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1183889908-1121187702=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jul 2005, Tom Zanussi wrote:
[..]
> > DTrace real examples shows something completly diffret.
> > MANY things (if not ~almost all) can be kept only in aggregated form
> > during experiments.
>
> But you can also do the aggregation in user space if you have a cheap
> way of getting it there, as we've shown with some of the examples.

Sorry but real life examples shows that store chunk of 
data in agregator is less expensive than context switch neccessary for 
store data or time neccasy for send and handle signal from buffer like 
"I'm full! let me out of here ..".

[..]
> > store raw data. What you need ? only one counter (few bytes) instead of huge
> > amount of memeory for buffer and store logs. Try measure something like
> > scheduler with possible small system distruption.
>
> Most of the time the data is just being buffered and only when the
> buffer is full is it written to disk, as one write.  If that's too
> disruptive, then maybe you do need to do some aggregation in the kernel,
> but it sounds like a special case.

OK .. "so you can say better is stop flushing buffers on measure which 
wil take day or more" ? :_)
Some DTrace probes/technik are specialy prepared for long or evel very 
long time experiment wich will only prodyce few lines results on end of 
experiment.
Look at DTrace documentation for speculative tracing:
http://docs.sun.com/app/docs/doc/817-6223/6mlkidli7?a=view

Some experiments do not have deterinistic time and must be finished after 
i. e. "occasional failing". What if it will take so long so you will fill 
all avalaible storage in relayfs way ?
OK, never mind .. you have discontinued storage. Using kind speculative 
tracing way I'll have result *just after* "occasional failing" and you 
will start parse data stored using relayfs.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1183889908-1121187702=:6919--
