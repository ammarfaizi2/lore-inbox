Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbSLKJie>; Wed, 11 Dec 2002 04:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSLKJie>; Wed, 11 Dec 2002 04:38:34 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:17682 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267094AbSLKJid>;
	Wed, 11 Dec 2002 04:38:33 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Wahib Nackad" <wahibn@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is not plain file nor directory 
In-reply-to: Your message of "Wed, 11 Dec 2002 00:16:25 -0000."
             <F155L9OqNHKEn8diHNK0001ecdb@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Dec 2002 20:46:01 +1100
Message-ID: <10451.1039599961@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002 00:16:25 +0000, 
"Wahib Nackad" <wahibn@hotmail.com> wrote:
>I'm able to compile kernel 2.4.20 via SRPMS with spec file without problem 
>as long as I don't enable pcmcia support with the kernel. If I enable pcmcia 
>support, then compilation fail when the 'make module_install' command runs 
>and return the following error message for each pcmcia drivers:
>
>depmod: 
>/var/tmp/kernel-2.4.20-root/lib/modules/2.4.20-1/pcmcia/xircom_tulip_cb.o is 
>not plain file nor directory

depmod detects symlinks and resolves them, this error should never
happen for valid symlinks.  Run depmod with -v, post the 10 lines
starting with 'resolving xircom_tulip_cb.o symlink'.

