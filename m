Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVGLPcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVGLPcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGLPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:32:31 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:2925 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261512AbVGLPbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:31:02 -0400
Date: Tue, 12 Jul 2005 17:30:56 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Baruch Even <baruch@ev-en.org>
cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <42D3D1F3.1030405@ev-en.org>
Message-ID: <Pine.BSO.4.62.0507121714210.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <42D3D1F3.1030405@ev-en.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1511738831-1121182256=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1511738831-1121182256=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jul 2005, Baruch Even wrote:
[..]
>> Usualy/for now relayfs is used as base infrastructure for variuos
>> debuging/measuring.
>> IMO storing raw data and transfer them to user space it is wrong way.
>> Why ? Becase i adds very big overhead for memory nad storage.
>> Big .. compare to in situ storing partialy analyzed data in conters
>> and other like it is in DTrace.
>>
>> IMO much better will be add base/template set of functions for use in
>> KProbes probes which will come with KProbes code as base tool set. It
>> will allow cut transfered data size from megabites/gigabyutes to hundret
>> bytes/kilo bytes, make debuging/measuring more smooth without additional
>> latency for transfer data outside kernel space.
>
> There is no relation between using kprobes and reducing the logged data
> size. At the end the debugging/tracing facility is there to provide data
> to the developer who tries to detect the problem or ensure correctness.

Yes, now relayfs and KProbes this two diffrent stories without 
strict relation but this relation exist on higher level. Both are used 
for solve tha same problems (for measure, watch, some skeleton debug).

Collecting data _without_ dynamically hanged probes requires relayfes but 
if collected data can be rolled to data types what you will want to see as 
result of experiment (i.e. number of calls of some code asociated with 
differnt stack path or number of I/O operation asociated with avarange 
transfered data in I/O operations) sucking result data will not be an 
issue :)

> The kprobes can only serve as a replacement to changing the source code
> in order to extract the debugging information, and it does it very well.
>
> Cutting the amount of data transferred is only possible if you add the
> problem detection logic into the kernel and only transport problem
> reports to user-mode.

Of course yes. I want only say: if KProbes will have this logic relayfs 
will not be neccessary and instead focusing on develop and merge relayfs
better will be spend time on prepare code for this additional logic 
(and probably neccesasary amount of code will be compareable to current 
relayfs code size :)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1511738831-1121182256=:6919--
