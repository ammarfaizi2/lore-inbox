Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310316AbSCLBmu>; Mon, 11 Mar 2002 20:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310323AbSCLBmh>; Mon, 11 Mar 2002 20:42:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310309AbSCLBlw>;
	Mon, 11 Mar 2002 20:41:52 -0500
Message-ID: <3C8D5CCD.3050208@mandrakesoft.com>
Date: Mon, 11 Mar 2002 20:41:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111638290.26250-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>The only common factor here is the "synchronize with other requests" - I
>feel strongly (much more strongly than any parsing notion) that the raw
>requests have to be passed down the "struct request" and NOT be done the
>way they are traditionally done (ie completely outside the request stream,
>with no synchronization at all with any IO currently in progress).
>
agreed

>>I think "future new commands" is total FUD, the idea that some new command
>>would come along and be so instantly popular, useful and incompatible that
>>all Linux boxes would require it before the next kernel or driver update
>>is silly at best, and I'm working hard to keep this on a civil plane.
>>
>
>It has nothing to do with "new" commands, and everything to do with
>"random vendor-specific commands and the vendor-specific tools". Commands
>that simply should _never_ be parsed in the kernel, because we do not want
>to care about 10 different vendors 10 different revisions of their
>firmware having 10 different small random special commands for that
>particular drive.
>
>In particular, a user that upgrades his hardware should never _ever_ have
>to upgrade his kernel just because some random disk diagnostic tool needs
>support for a disk that is new and has new diagnostics.
>
Are such random vendor-specific commands really that common?

Linus, would it be acceptable to you to include an -optional- filter for 
ATA commands?  There is definitely a segment of users that would like to 
firewall their devices, and I think (as crazy as it may sound) that 
notion is a valid one.

    Jeff





