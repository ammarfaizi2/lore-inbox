Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTEHLpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbTEHLpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:45:22 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:1288 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261358AbTEHLpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:45:21 -0400
Message-ID: <3EBA46FA.5020605@aitel.hist.no>
Date: Thu, 08 May 2003 14:00:58 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Timothy Miller <miller@techsource.com>, Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com> <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com> <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com> <Pine.LNX.4.53.0305071547060.13869@chaos> <3EB96FB2.2020401@techsource.com> <Pine.LNX.4.53.0305080729410.16638@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 7 May 2003, Timothy Miller wrote:

>>On typical processors, when one gets an interrupt, the current program
>>counter and processor state flags are pushed onto a stack.  Which stack
>>gets used for this?
>>
> 
> 
> In protected mode, the kernel stack. And, regardless of implimentation
> details, there can only be one. It's the one whos stack-selector
> is being used by the CPU. So, in the case of Linux, with multiple

A little contradiction there.  "There can only be one" versus
"the one whos stack-selector is being used by the CPU"

Of course there can only be one stack _at a time_,
but the stack selector is switched as part of the context
switch - so there is one stack per process.

The same applies to kernel stacks. There can only be
one at a time, but the kernel stack pointer is
updated on task switches so there is one kernel
stack per process too.

> kernel stacks (!?????), one for each process, whatever process is
> running in kernel mode (current) has it's SS active. It's the
> one that gets hit with the interrupt.

Helge Hafting


