Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTECVcV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTECVcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:32:21 -0400
Received: from [62.37.236.142] ([62.37.236.142]:41170 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263428AbTECVcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:32:20 -0400
Message-ID: <3EB4385B.8050802@wanadoo.es>
Date: Sat, 03 May 2003 23:44:59 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [ Compile Regression on i386 ]-2.4.21-rc1-ac4 _critical_ compile
 errors
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel compilation output summary:

--drivers/char/ipmi/ipmi_kcs_intf.c--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipmi_kcs_intf  -c -o ipmi_kcs_intf.o ipmi_kcs_intf.c
ipmi_kcs_intf.c:1035:42: ../drivers/acpi/include/acpi.h: No such file or directory
ipmi_kcs_intf.c:1036:45: ../drivers/acpi/include/actypes.h: No such file or directory
ipmi_kcs_intf.c: In function `acpi_find_bmc':
ipmi_kcs_intf.c:1061: `acpi_table_header' undeclared (first use in this function)
ipmi_kcs_intf.c:1061: (Each undeclared identifier is reported only once
ipmi_kcs_intf.c:1061: for each function it appears in.)
ipmi_kcs_intf.c:1061: `spmi' undeclared (first use in this function)
make[2]: [ipmi_kcs_intf.o] Error 1 (ignored)
ld -m elf_i386 -r -o ipmi_kcs_drv.o ipmi_kcs_sm.o ipmi_kcs_intf.o
ld: cannot open ipmi_kcs_intf.o: No such file or directory
make[2]: [ipmi_kcs_drv.o] Error 1 (ignored)
--end--

--fs/devpts/inode.c--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c: In function `init_devpts_fs':
inode.c:233: `devpts_upcall_new' undeclared (first use in this function)
inode.c:233: (Each undeclared identifier is reported only once
inode.c:233: for each function it appears in.)
inode.c:234: `devpts_upcall_kill' undeclared (first use in this function)
inode.c: In function `exit_devpts_fs':
inode.c:244: `devpts_upcall_new' undeclared (first use in this function)
inode.c:245: `devpts_upcall_kill' undeclared (first use in this function)
make[1]: [inode.o] Error 1 (ignored)
rm -f devpts.o
ld -m elf_i386  -r -o devpts.o root.o inode.o
ld: cannot open inode.o: No such file or directory
make[1]: [devpts.o] Error 1 (ignored)
--end--

--drivers/hotplug/ibmphp_core.c--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ibmphp_ebda  -c -o ibmphp_ebda.o ibmphp_ebda.c
ibmphp_ebda.c: In function `create_file_name':
ibmphp_ebda.c:675: warning: return makes integer from pointer without a cast
ibmphp_ebda.c:711: warning: return makes integer from pointer without a cast
ibmphp_ebda.c:666: warning: unused variable `ptr_chassis_num'
ibmphp_ebda.c:666: warning: unused variable `ptr_rxe_num'
ibmphp_ebda.c:666: warning: unused variable `ptr_slot_num'
ibmphp_ebda.c: In function `ebda_rsrc_controller':
ibmphp_ebda.c:992: `slot_cur' undeclared (first use in this function)
ibmphp_ebda.c:992: (Each undeclared identifier is reported only once
ibmphp_ebda.c:992: for each function it appears in.)
ibmphp_ebda.c:995: parse error before ')' token
make[1]: [ibmphp_ebda.o] Error 1 (ignored)
--end--

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!



