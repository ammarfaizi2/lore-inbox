Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRAINGa>; Tue, 9 Jan 2001 08:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAINGU>; Tue, 9 Jan 2001 08:06:20 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:248 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129778AbRAINGM>; Tue, 9 Jan 2001 08:06:12 -0500
Date: Tue, 9 Jan 2001 09:18:08 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ad1848.c: include missing restore_flags
Message-ID: <20010109091808.G21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109001443.A20786@conectiva.com.br>; from acme@conectiva.com.br on Tue, Jan 09, 2001 at 12:14:43AM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

	Please apply.

- Arnaldo

--- linux-2.4.0-ac4/drivers/sound/ad1848.c	Thu Aug 24 07:40:05 2000
+++ linux-2.4.0-ac4.acme/drivers/sound/ad1848.c	Tue Jan  9 08:55:58 2001
@@ -28,6 +28,7 @@
  *		          of irqs. Use dev_id.
  * Christoph Hellwig	: adapted to module_init/module_exit
  * Aki Laukkanen	: added power management support
+ * Arnaldo C. de Melo	: added missing restore_flags in ad1848_resume
  *
  * Status:
  *		Tested. Believed fully functional.
@@ -2751,6 +2752,7 @@
 		bits = interrupt_bits[devc->irq];
 		if (bits == -1) {
 			printk(KERN_ERR "MSS: Bad IRQ %d\n", devc->irq);
+			restore_flags(flags);
 			return -1;
 		}
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
