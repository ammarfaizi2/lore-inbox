Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVJPAKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVJPAKk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJPAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 20:10:40 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54679 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751267AbVJPAKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 20:10:40 -0400
Message-ID: <43519A77.2040806@vc.cvut.cz>
Date: Sun, 16 Oct 2005 02:10:31 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Coywolf Qi Hunt <coywolf@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe>  <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk> <2cd57c900510150056j2a6af6e5gf93ce9fa4ef16aac@mail.gmail.com> <Pine.LNX.4.64.0510150909050.25927@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0510150909050.25927@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Sat, 15 Oct 2005, Coywolf Qi Hunt wrote:
> 
>>On 10/15/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>>
>>>echo s > /proc/sysrq-trigger
>>>echo u > /proc/sysre-trigger
>>>echo s > /proc/sysrq-trigger
>>
>>What the purpose of the second sync?
> 
> 
> Allows any i/o initiated between the first sync and the remount r/o to 
> complete.  Remember that r/o mounting doesn't stop i/o.  It only stops you 
> from writing to the fs at the vfs layer.  Once a write/modification has 
> entered the fs driver it will get written no matter what, unless the 
> "reboot" sysrq is triggered in which case the kernel just reboots 
> immediately.
> 
> Maybe it is just paranoia on my part but I have gotten used to hitting 
> Alt+PrtScr+S, +U, +S, +B so I do it automatically.

Second sync is a must, otherwise remounting read-only is not written to 
the filesystem (at least in my case) so no fsck is saved.   But you can 
save first sync (before remount), and then you get nice sequence which 
even admins comming from Windows can remember - they have to use USB to 
safely reboot their Linux systems ;-)  (alt-sysrq-U, S, B)
								Petr

