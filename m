Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAFHlu>; Sat, 6 Jan 2001 02:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAFHlk>; Sat, 6 Jan 2001 02:41:40 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:10244 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129401AbRAFHlc>;
	Sat, 6 Jan 2001 02:41:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "-=da TRoXX=-" <TRoXX@LiquidXTC.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer as a module 
In-Reply-To: Your message of "Fri, 05 Jan 2001 18:52:45 BST."
             <000d01c07740$516a30e0$fd1942c3@bluescreen> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jan 2001 18:41:25 +1100
Message-ID: <18019.978766885@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001 18:52:45 +0100, 
"-=da TRoXX=-" <TRoXX@LiquidXTC.nl> wrote:
>I have a very simple question:
>I used to compile-in my framebuffer-device in the kernel
>then i just appended "video=tdfxfb:1024x768-32@70" in lilo.conf and it
>worked..
>
>now i compiled it as a module, and want modprobe to start it up for me..
>how can this be done?
>modprobe tdfxfb 1024x768-32@70
>won't work, because there is no '=' sign in it so modprobe doesn't recognize
>it as a parameter, and doesn't pass it.

A quick look at drivers/video/tdfxfb.c shows a complete lack of
MODULE_PARM entries so modprobe/insmod will not let specify any
parameters.  Ask the tdfxfb author to add this feature, or code it
yourself.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
