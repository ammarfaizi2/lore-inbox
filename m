Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbQKRIKm>; Sat, 18 Nov 2000 03:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbQKRIKd>; Sat, 18 Nov 2000 03:10:33 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:41485 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130664AbQKRIKU>;
	Sat, 18 Nov 2000 03:10:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ? 
In-Reply-To: Your message of "Sat, 18 Nov 2000 00:15:35 CDT."
             <3A161077.7C94EC6E@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 Nov 2000 18:40:13 +1100
Message-ID: <21341.974533213@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000 00:15:35 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>What is the difference between a module that exports no symbols and
>includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
>EXPORT_NO_SYMBOLS?

When modules were first introduced, all symbols were automatically
exported.  For kernel 2.0 compatibility, a module without
EXPORT_NO_SYMBOLS actually exports everything.  There are flags on
insmod to override this default.  modutils 2.5 will remove this
backwards compatibility, no module will export symbols unless they are
explicitly exported.  If you are feeling brave, add
  insmod_opt=-x
to your modules.conf and see what breaks in 2.4.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
