Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289297AbSANXjO>; Mon, 14 Jan 2002 18:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSANXjF>; Mon, 14 Jan 2002 18:39:05 -0500
Received: from ns.suse.de ([213.95.15.193]:15888 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289297AbSANXit>;
	Mon, 14 Jan 2002 18:38:49 -0500
Date: Tue, 15 Jan 2002 00:38:45 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Erik Andersen <andersen@codepoet.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb fix, fixed
In-Reply-To: <20020114031420.GA18525@codepoet.org>
Message-ID: <Pine.LNX.4.33.0201150036150.22605-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0201150036152.22605@Appserv.suse.de>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Erik Andersen wrote:

> > This patch is needed to make radeonfb compile and work.
> > It is based on an earlier patch on the list attributed to
> > Ani Joshi, plus adds the needed devinit fix.
> Oops.  That patch had some crap in it.  Lets try that again.

Uncompressed, that patch was just 4kb. When not too big, it's
considered acceptable (and preferred) to send them as plaintext
to the list for ease of quoting.

Patch looks ok, but this bit..

diff -urN linux/drivers/video.virgin/radeonfb.c
linux/drivers/video/radeonfb.c
--- linux/drivers/video.virgin/radeonfb.c   Sun Jan 13 19:09:54 2002
+++ linux/drivers/video/radeonfb.c  Sun Jan 13 19:41:00 2002
@@ -686,7 +686,7 @@
    name:       "radeonfb",
    id_table:   radeonfb_pci_table,
    probe:      radeonfb_pci_register,
-   remove:     radeonfb_pci_unregister,
+   remove:     __devexit_p(radeonfb_pci_unregister),
 };

Is that really needed ?  Hotplugable radeons ?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

