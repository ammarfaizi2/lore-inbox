Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUATLZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUATLZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:25:22 -0500
Received: from pl829.nas911.n-yokohama.nttpc.ne.jp ([210.139.42.61]:42698 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id S265352AbUATLZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:25:08 -0500
Message-ID: <400D0FFB.3060006@yk.rim.or.jp>
Date: Tue, 20 Jan 2004 20:24:43 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
References: <400BDC85.8040907@wanadoo.es>	<1074532919.1895.32.camel@mulgrave>		<3747775408.1074537497@aslan.btc.adaptec.com>	<1074559838.2078.1.camel@mulgrave> 	<3942145408.1074564149@aslan.btc.adaptec.com> <1074573912.2081.81.camel@mulgrave>
In-Reply-To: <1074573912.2081.81.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a feeling that Linus summed up
what the maintainer is like in the context
of linux kernel development.

But I have a comment.

> The recovery code does work. 

Maybe. I have not tried a few problematic devices under
my PC lately. These devices
usually caused troube under 2.2.xx series, and even under late
2.3.y series for a while.
The symptom was essentially a reset storm that made the system
unusable.
Given the various patches accumalating, maybe the symptom
is tolerable now, but again I see some mention of
unusable system response even today.
So I suspect the problem is still there for certain type
of hardware problems.

>You may want it to work differently, and
> that may make it work better, but that's an enhancement not a bug fix.

To people who have been bitten with such unusable system symptoms
the above statement simply  won't pass.

It is essentially a "performance *bug*" and
should be corrected IMHO.

> But it does do it successfully.  Something that currently works but
> could work better is an enhancement not a bug.

Again, to those people this is a correctable (and should be corrected)
performance "bug".

> I'm not against enhancements, even at this late stage in the
> stabilisation process. 

I am a little confused here. Are we talking about 2.4 series?
OK the subject line states 2.4.2[234].

I believe that there are a lot of user base, especially, people
who use server type machines with SCSI interface (and AIC chips
seem to be popular among these machines)
who would appreciate the enhanced (== perforamance
bug corrected) version of the SCSI subsystem.

I, for one, don't use AIC chip on my home PCs, but
do have some machines at the office which use them and
will appreciate "enhanced" SCSI subsystem after all these years.

As for 2.6.zz, aren't there any chance of introducing hooks into EH
framework? The previous discussion suggested that it needs
to wait for 2.7 series. Too bad :-(

I feel that these error handling issues of SCSI subsystem
will have to be solved once for all sooner or later in the mainline
or otherwise as we see the vendors of commercial distribution probably
need to keep a separate tree (which they may have to, anyway,  deal
with other quirks of the mainline kernel, etc.) for a long time to
come and this is rather waste of man-power resources IMHO.

In any case, with all due respect
I don't think that the discussion goes anywhere unless we
recognize that someone's "mere enhancement" is actually
other people's "serious performance bug correction".
I, for one, tend to see the topic discussed as
the performance "BUG" and so
am a little frustrated at the pace the
error handling scheme is being improved.

This is just a comment from a third party observer who,
unfortunately doesn't have the time to dig into
the code and offer a patch. (Yes I actually tried
once during 2.2.xx time-frame but was then repulsed at
the spaghetti code of the time and gave up.).

PS: One other thing is that the type of the bug
is hard to trigger unless you have a controlled
facility or some seeming working and yet
faulty devices which
generate bad condition in a short time, say a few minutes
into the operation . So I agree that
not all people see such problems.

Intermittently faulty SCSI devices are rather rare, aren't they?
Either a SCSI device such as disk is complete dead or
or healthy. Finding a faulty device that triggers error condition
from time to time is probably the key to observe the
problematic symptom being discussed. I wonder
if some disk manufacturers or someone could produce
a special firmware to generate error condition every minute or so
and send such disks to SCSI subsystem developers :-)

PPS: Some would argue that if such devices are so rare
then we can ignore them. Heck, no!
I have seen Solaris log files where such faulty
behavior occur from time to time and was dealt with
very gracefully without the system being rendered unusable.
So the ratio of the such devices are small, but the sheer number
of computer installation today make such incidents visible indeed.

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
