Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270622AbTGURsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270650AbTGURrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:47:47 -0400
Received: from smtp11.eresmas.com ([62.81.235.111]:23187 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S270652AbTGURpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:45:40 -0400
Message-ID: <3F1C2A44.7020504@wanadoo.es>
Date: Mon, 21 Jul 2003 20:00:36 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Tosatti <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-pre7 bugs
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

there is a bug at drivers/hotplug/acpiphp_glue.c :

--cut--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS -include /datos/kernel/linux/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=acpiphp_glue  -c -o acpiphp_glue.o acpiphp_glue.c
acpiphp_glue.c:1172: variable `acpi_pci_hp_driver' has initializer but incomplete type
acpiphp_glue.c:1173: unknown field `add' specified in initializer
acpiphp_glue.c:1173: warning: excess elements in struct initializer
acpiphp_glue.c:1173: warning: (near initialization for `acpi_pci_hp_driver')
acpiphp_glue.c:1174: unknown field `remove' specified in initializer
acpiphp_glue.c:1174: warning: excess elements in struct initializer
acpiphp_glue.c:1174: warning: (near initialization for `acpi_pci_hp_driver')
acpiphp_glue.c: In function `acpiphp_glue_init':
acpiphp_glue.c:1188: warning: implicit declaration of function `acpi_pci_register_driver'
/datos/kernel/linux/include/linux/ctype.h: At top level:
acpiphp_glue.c:1172: storage size of `acpi_pci_hp_driver' isn't known
make[2]: *** [acpiphp_glue.o] Error 1
make[2]: Leaving directory `/datos/kernel/linux/drivers/hotplug'
make[1]: *** [_modsubdir_hotplug] Error 2
make[1]: Leaving directory `/datos/kernel/linux/drivers'
make: *** [_mod_drivers] Error 2
--end--

and drivers/scsi/aic79xx is empty, delete it.

-thanks-

regards,
-- 
I don't even see the code. All I see is blonde, brunette, redhead.

