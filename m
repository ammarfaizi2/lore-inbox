Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWIRWSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWIRWSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWIRWSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:18:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:46268 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751214AbWIRWSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:18:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gcfurgsjTPu0Nb2dZPDHnkwgipB6VaMbTf3lsZfGJQMkgBtiJsXIBNuQxC2QxTKJbvdl0tPFktl5YYOaRykrhQ6HIMBzsJJ81B4dVzcbGYQFMrG1YAMaM6FfK0VWMk3CYQgQ9XrOGBGor7URR6MCs26EimRg/WBWPQRH+rojDQ0=
Message-ID: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
Date: Tue, 19 Sep 2006 00:18:51 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Math-emu kills the kernel on Athlon64 X2
Cc: billm@melbpc.org.au, billm@suburbia.net,
       "Linus Torvalds" <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
tried this with) and then boot the kernel with "no387" then I only get
as far as lilo's "...Booting the kernel." message and then the system
hangs.

The kernel is a 32bit kernel build for K8 and my CPU is a Athlon64 X2 4400+

If I boot the same kernel without the "no387" option, then it boots
and runs just fine, so it seems the math emulator code is lethal on
newer CPU's :-(

Now, I need some help debugging this. The crash happens very early and
doesn't result in anything printed to the screen (I guess it's too
early to call printk()) - How on earth can I get a lead on what's
going wrong?  Any help would be appreciated.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
