Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIANy>; Mon, 8 Jan 2001 19:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAIANo>; Mon, 8 Jan 2001 19:13:44 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:21245 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129226AbRAIANb>; Mon, 8 Jan 2001 19:13:31 -0500
Date: Mon, 8 Jan 2001 20:25:33 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Drew Eckhardt <drew@PoohSticks.ORG>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de620.c: nitpicking
Message-ID: <20010108202533.F17087@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Drew Eckhardt <drew@PoohSticks.ORG>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108201103.E17087@conectiva.com.br>; from acme@conectiva.com.br on Mon, Jan 08, 2001 at 08:11:04PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying, no need to restore_flags here, as it is
restored in the beginning of this if block.

- Arnaldo


--- linux-2.4.0-ac3/drivers/scsi/53c7,8xx.c	Fri Oct 13 18:40:51 2000
+++ linux-2.4.0-ac3.acme/drivers/scsi/53c7,8xx.c	Mon Jan  8 20:24:35 2001
@@ -1899,7 +1899,6 @@
 		hostdata->script, start);
 	    printk ("scsi%d : DSPS = 0x%x\n", host->host_no,
 		NCR53c7x0_read32(DSPS_REG));
-	    restore_flags(flags);
 	    return -1;
 	}
     	hostdata->test_running = 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
