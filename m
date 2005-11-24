Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVKXRV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVKXRV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVKXRV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:21:56 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:31968 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932454AbVKXRV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:21:56 -0500
Message-ID: <4385F6A8.60808@t-online.de>
Date: Thu, 24 Nov 2005 18:21:44 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: nathan.cline@gmail.com
CC: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Patch to framebuffer
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XNBHw0ZHwemzz4C-P0GpMHNts7rNftidnND8cA9psLhNAAXThivpEn@t-dialin.net
X-TOI-MSGID: 48b1e2c5-df64-4ddb-ac32-56b9c69d4a52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Updating only one framebuffer console at a time is a real feature for me,
it allows a really quick developement cycle:

            compile vesafb into the kernel, cyblafb as a module
            start with vesafb
loop:    load cyblafb
            switch to cyblafb, test it
            correct bugs, compile new cyblafb module
            switch to vesafb
            unload vesafb
            goto loop
           
Although both vesafb and cyblafb control the same hardware, this is
possible because of the "feature" you want to remove.

On the other hand I do understand that your patch is valuable, if I had
two monitors attached I certainly would like to be able to use both at the
same time.

I believe that you should introduce your code either as a compile time
option or even better it should be possible to disable it via sysfs:

     /sys/class/graphics/fb?/update_mode

0 could be the default and would activate your new code
1 would restore the old "one active" mode.

Please  consider my arguments and join us at

linux-fbdev-devel@lists.sourceforge.net

cu,
 Knut
