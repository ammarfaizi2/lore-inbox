Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUL2PMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUL2PMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUL2PMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:12:21 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:10733 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261356AbUL2PLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:11:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=IL+iCiSH4wqe+FeF6lYNkWCAgR7U8q/NlFkkJwIvvS+W5QtEqqECkaQ4C25Y3L/c0k4bV2Y3QH4efWI0MiFbqna8tCKHVwJTgwedGoYgaiiajwyHyv20+8SgeUaj2Zlk+OA1eCrK8wdJpyJGvaBmdvQjykyOR71K0lTa7r5IRZE=
Message-ID: <105c793f04122907116b571ebf@mail.gmail.com>
Date: Wed, 29 Dec 2004 10:11:52 -0500
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I recently installed Linux 2.6.10 on my Gateway Solo 2500 notebook
after using it happily with 2.4.27 (aside from some ACPI sleeping
issues). Since installing the new kernel, I've noticed an odd problem
with the Toshiba PS/2 touchpad which is used as a cursor. If I move my
finger left and right along the 'bottom' portion of the touchpad or up
and down along the right side, there is no movement from the mouse
cursor at all. This behavior shows up using gdm and XFree86. Running
'xev' produces no output when these sides are used. However, if I move
my finger left-right along the top side or up-down along the left
side, the cursor moves just fine. Tapping the pad to click in the
non-working areas and moving the finger from outside of these areas
and then into them, however, works fine.

It's almost as if the portion of the pad that is sensitive to movement
has been shifted up and to the left (except that clicking in and
dragging into this area works).

I think this might have something to do with the drag-lock function
because if I move the cursor from, say, the center of the pad and down
to the lower side, the cursor will begin to move downward when my
finger gets into the portion of the pad that does not function 100%.
(This is really only a wild-ass guess, though.)

I've tried killing gdm and loading up my old 2.4 kernels to be sure
it's not something else. I've also tried kernels 2.6.5.and 2.6.0 and a
clean 2.6.10 tree (without the acpi and swsusp2 patches that I want)
to be sure that this isn't likely to be something that just cropped up
recently. The old (good, working) behavior is found in a 2.4 kernel
and some new (bad, faulty) behavior is found in the 2.6 kernels that
I've tried. I've also tried booting with acpi=off to no avail.

I realize this problem may seem odd, but I've described it as best I
can. I also realize that other people are having issues with pointing
devices and keyboards, so this could just be a related problem that
will be fixed when those others are fixed as well.

Thanks.
-- 
                         -Andy
