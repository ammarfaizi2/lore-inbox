Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAIC36>; Mon, 8 Jan 2001 21:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAIC3s>; Mon, 8 Jan 2001 21:29:48 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:42741 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129523AbRAIC3j>; Mon, 8 Jan 2001 21:29:39 -0500
Date: Tue, 9 Jan 2001 00:29:24 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Michael Neuffer <mike@i-Connect.Net>, neuffer@mail.uni-mainz.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH] eata_dma.c: include missing restore_flags
Message-ID: <20010109002924.B20786@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Michael Neuffer <mike@i-Connect.Net>, neuffer@mail.uni-mainz.de,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac4/drivers/scsi/eata_dma.c	Mon Jan  8 20:39:29 2001
+++ linux-2.4.0-ac4.acme/drivers/scsi/eata_dma.c	Tue Jan  9 00:25:54 2001
@@ -482,7 +482,7 @@
         DBG(DBG_REQSENSE, printk(KERN_DEBUG "Tried to REQUEST SENSE\n"));
 	cmd->result = DID_OK << 16;
 	done(cmd);
-
+	restore_flags(flags);
 	return(0);
     }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
