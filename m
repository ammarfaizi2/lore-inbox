Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132236AbQKSImn>; Sun, 19 Nov 2000 03:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132332AbQKSImc>; Sun, 19 Nov 2000 03:42:32 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:28433 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132236AbQKSImV>;
	Sun, 19 Nov 2000 03:42:21 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ? 
In-Reply-To: Your message of "Sat, 18 Nov 2000 18:50:00 BST."
             <200011181750.SAA14559@cave.bitwizard.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 19 Nov 2000 19:12:13 +1100
Message-ID: <2681.974621533@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000 18:50:00 +0100 (MET), 
R.E.Wolff@BitWizard.nl (Rogier Wolff) wrote:
>Compile a kernel, marking "sx" and "riscom8" as modules. 
>
>Install, modprobe sx, and voila, you'll pull in the riscom because
>its "block_til_ready" static was found to satisfy the block_til_ready
>from generic_serial. 

If that is true then it is a bug in either depmod or modprobe.  However
I cannot reproduce it using kernel 2.4.0-test11-pre7 and modutils
2.3.20.  In particular depmod correctly recognises that sx depends on
block_til_ready in generic_serial, not in riscom.  Which kernel, which
modutils, which .config?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
