Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSIEMv2>; Thu, 5 Sep 2002 08:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSIEMv2>; Thu, 5 Sep 2002 08:51:28 -0400
Received: from post.polcard.com.pl ([193.109.115.28]:6610 "HELO
	post.polcard.com.pl") by vger.kernel.org with SMTP
	id <S317463AbSIEMv1>; Thu, 5 Sep 2002 08:51:27 -0400
Date: Thu, 5 Sep 2002 14:56:45 +0200
From: =?iso-8859-2?Q?Jaros=B3aw?= Bekas <jaroslaw.bekas@polcard.com.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac2
Message-ID: <20020905125645.GA22652@polcard.com.pl>
Reply-To: =?iso-8859-2?Q?Jaros=B3aw?= Bekas 
	  <jaroslaw.bekas@polcard.com.pl>
References: <20020905090558.GA5199@polcard.com.pl> <200209051029.g85ATqS07183@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200209051029.g85ATqS07183@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Organization: Polcard S.A.
X-Kernel-Version: 2.4.20-pre4
X-Machine: jaro - i686
X-Operating-System: Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compile process was ok 
but i have unsresolved symbol in ide modules: 

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.20-pre5-ac2; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre5-ac2/kernel/drivers/ide/ide-disk.o
depmod:         ide_remove_proc_entries_Rsmp_6c3866e6
depmod:         proc_ide_read_geometry_Rsmp_50fed6f7
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre5-ac2/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre5-ac2/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         destroy_proc_ide_drives_Rsmp_2ac4226e
depmod:         proc_ide_create_Rsmp_a8e0f104
depmod:         ide_remove_proc_entries_Rsmp_6c3866e6
depmod:         ide_scan_pcibus
depmod:         ide_add_proc_entries_Rsmp_52fb2e3b
depmod:         create_proc_ide_interfaces_Rsmp_ab2c600e
depmod:         proc_ide_read_capacity_Rsmp_46b2a30d
depmod:         proc_ide_destroy_Rsmp_35e1351c

there is no possible to have ide in module ?

-- 
Jaros³aw Bekas
PolCard S.A.
