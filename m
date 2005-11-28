Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVK1Apn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVK1Apn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 19:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVK1Apn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 19:45:43 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:34196 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751205AbVK1Apm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 19:45:42 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: umount
Date: Mon, 28 Nov 2005 11:45:21 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com>
References: <200511272154.jARLsBb11446@apps.cwi.nl>
In-Reply-To: <200511272154.jARLsBb11446@apps.cwi.nl>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005 22:54:11 +0100 (MET), <Andries.Brouwer@cwi.nl> wrote:

>Recently I have seen cases where I/O to a device with bad media
>was never noticed (except in the syslog). I think that is bad.
>The application writes, but the stuff written lives in buffers.
>The close() still does not force file I/O.
>But the umount() causes the I/O to happen. Writes fail and the
>syslog is full of messages. But the user does not see any messages,
>the umount returns without error, and there is no reason to suspect
>that anything is wrong.
>
>I am not sure about the correct solution.
>Perhaps umount should return -EIO if it did the umount but
>I/O errors happened?

I wrote a bad boot disk recently, then I write; sync; cmp until 
floppy image matched source, a user can do that if they care... 

Related: observed that a USB CompactFlash adapter under windows, 
the device light goes out when unmounted, but under linux the 
light stays on after umount, this seems bad from usability perspective.  

It leaves me with a little distrust of linux' handling of non-locked 
removable media (as opposed to lockable media like a zipdisk or cdrom).

Grant.
