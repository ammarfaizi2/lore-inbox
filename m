Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSKWRAR>; Sat, 23 Nov 2002 12:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSKWRAR>; Sat, 23 Nov 2002 12:00:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18941 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267034AbSKWRAQ>; Sat, 23 Nov 2002 12:00:16 -0500
Date: Sat, 23 Nov 2002 18:07:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Jack_Hammer@adaptec.com
Subject: Re: Linux 2.4.20-rc3
Message-ID: <20021123170721.GJ14886@fs.tum.de>
References: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
 
the patch below is still needed to fix a .text.exit error.
 
Please apply
Adrian

--- linux-2.4.19-full-nohotplug/drivers/scsi/ips.c.old	2002-10-04 18:49:10.000000000 +0200
+++ linux-2.4.19-full-nohotplug/drivers/scsi/ips.c	2002-10-04 18:50:02.000000000 +0200
@@ -305,21 +305,21 @@
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    }; 
            
    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 
    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 
 #endif
