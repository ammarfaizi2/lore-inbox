Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276460AbRI2Ide>; Sat, 29 Sep 2001 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276461AbRI2IdY>; Sat, 29 Sep 2001 04:33:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49930 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276460AbRI2IdI>; Sat, 29 Sep 2001 04:33:08 -0400
Date: Sat, 29 Sep 2001 10:31:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: hugang <linuxbest@soul.com.cn>
Cc: detlefc@users.sourceforge.net, acpi@phobos.fachschaften.tu-muenchen.de,
        linux-kernel@vger.kernel.org, seasons@falcon.sch.bme.hu
Subject: Re: [Patch] swsusp for 2.4.10
Message-ID: <20010929103134.A28329@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010928235333.A1468@bug.ucw.cz> <20010929095454.6ca54f34.linuxbest@soul.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010929095454.6ca54f34.linuxbest@soul.com.cn>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I should get some software that checks for mails that *should* have
> >attachments. Here it is:
> >								Pavel
> >-- 
> >I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> >Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
> >
> You lost vmlinux.lds patch .

Yep.

--- clean/arch/i386/vmlinux.lds	Sun Jul  8 23:26:00 2001
+++ linux-swsusp/arch/i386/vmlinux.lds	Thu Sep 27 12:35:19 2001
@@ -54,6 +54,12 @@
   __init_end = .;
 
   . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
+  . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
   . = ALIGN(32);


							Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
