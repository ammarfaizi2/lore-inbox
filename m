Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSH0KnX>; Tue, 27 Aug 2002 06:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSH0KnX>; Tue, 27 Aug 2002 06:43:23 -0400
Received: from radio-112-20.poa.terraempresas.com.br ([200.176.112.20]:49674
	"EHLO rush.interage.com.br") by vger.kernel.org with ESMTP
	id <S315503AbSH0KnW>; Tue, 27 Aug 2002 06:43:22 -0400
Message-ID: <3D6B58DC.2020002@interage.com.br>
Date: Tue, 27 Aug 2002 07:47:56 -0300
From: Mauricio Pretto <pretto@interage.com.br>
Organization: Interage Integradora
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us, pt-br
MIME-Version: 1.0
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre4-ac2 does not compile
References: <3D6B30E4.EE502613@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Alan send this patch for that problem.

--- drivers/ide/Makefile~       2002-08-26 13:06:26.000000000 +0100
+++ drivers/ide/Makefile        2002-08-26 13:06:26.000000000 +0100
@@ -19,6 +19,9 @@
  obj-m          :=
  ide-obj-y      :=

+subdir-$(CONFIG_BLK_DEV_IDEPCI)        += pci
+subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid
+
  obj-$(CONFIG_BLK_DEV_IDE)              += ide-probe.o ide-geometry.o 
ide-iops.o ide-taskfile.o ide.o ide-lib.o
  obj-$(CONFIG_BLK_DEV_IDEDISK)          += ide-disk.o
  obj-$(CONFIG_BLK_DEV_IDECD)            += ide-cd.o


Jean-Luc Coulon wrote:

> Hi !
> 
> ld -m elf_i386  -r -o idedriver.o ide-probe.o ide-geometry.o ide-iops.o
> ide-taskfile.o ide.o ide-lib.o ide-disk.o ide-dma.o ide-proc.o
> setup-pci.o pci/idedriver-pci.o legacy/idedriver-legacy.o
> ppc/idedriver-ppc.o arm/idedriver-arm.o raid/idedriver-raid.o
> ld: cannot open pci/idedriver-pci.o: No such file or directory
> make[4]: *** [idedriver.o] Erreur 1
> make[4]: Leaving directory `/usr/src/linux/drivers/ide'
> make[3]: *** [first_rule] Erreur 2
> make[3]: Leaving directory `/usr/src/linux/drivers/ide'
> make[2]: *** [_subdir_ide] Erreur 2
> make[2]: Leaving directory `/usr/src/linux/drivers'
> make[1]: *** [_dir_drivers] Erreur 2
> make[1]: Leaving directory `/usr/src/linux'
> make: *** [stamp-build] Erreur 2
> 
> --------
> Regards
> 	Jean-Luc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


-- 
Mauricio Pretto
Gerente de Produtos
Interage Integradora
http://www.interage.com.br

Técnico Certificado Conectiva Linux


