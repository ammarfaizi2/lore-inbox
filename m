Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUAYMkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 07:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUAYMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 07:40:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50449 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264147AbUAYMkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 07:40:17 -0500
Date: Sun, 25 Jan 2004 13:45:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marco Rebsamen <mrebsamen@swissonline.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Message-ID: <20040125124557.GA2036@mars.ravnborg.org>
Mail-Followup-To: Marco Rebsamen <mrebsamen@swissonline.ch>,
	linux-kernel@vger.kernel.org
References: <200401242137.34881.mrebsamen@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401242137.34881.mrebsamen@swissonline.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 09:37:34PM +0100, Marco Rebsamen wrote:
> 
> I try to compile my own kernel with 2.6.1 on suse 9. But i always get the same 
> error. i applied the patch 2.6.2-rc1 but wasn't helping.
>   objcopy -O binary -R .note -R .comment -S  vmlinux arch/i386/boot/
> compressed/vmlinux.bin
> make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Fehler 132

Looks like objcopy is failing.
Could you try to run the above command by hand in the top-level
directory of your kernel tree.
If it still fails try with
LANG=C LC_ALL=C objcopy ....

Just to check that language does not have any effect here.
I doubt so, but worth the try.

I browsed the objcopy src (a random version found by google)
without seeing where it could return 132

	Sam
