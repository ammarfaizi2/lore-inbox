Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293001AbSCDXNO>; Mon, 4 Mar 2002 18:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292997AbSCDXMz>; Mon, 4 Mar 2002 18:12:55 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:53009 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S292980AbSCDXMe>;
	Mon, 4 Mar 2002 18:12:34 -0500
Date: Tue, 5 Mar 2002 00:06:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp is at it... again
Message-ID: <20020304230623.GA16601@elf.ucw.cz>
In-Reply-To: <20020227113556.GE25104@atrey.karlin.mff.cuni.cz> <200202271516.g1RFGMs11398@fuji.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202271516.g1RFGMs11398@fuji.home.perso>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After about 20 resume cycles (compiled kernel with swsusp making
machine suspend/resume) I got that nasty FS corruption, again.

So... 

1) Maybe your ext3 patches are not at fault.

2) Be carefull using swsusp patch. Real carefull.

3) Don't trust fsck. At this kind of corruption, e2fsck 1.19 will
report "clean" but will not repair it, putting your fs into
self-destruct mode. Bad bad. Its fixed on new versions. Always run
fsck twice, second time with -f.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
