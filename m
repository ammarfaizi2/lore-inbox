Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbREUPTQ>; Mon, 21 May 2001 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261262AbREUPTG>; Mon, 21 May 2001 11:19:06 -0400
Received: from air.lug-owl.de ([62.52.24.190]:37650 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S261264AbREUPS6> convert rfc822-to-8bit;
	Mon, 21 May 2001 11:18:58 -0400
Date: Mon, 21 May 2001 17:18:55 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Compile fails an Alpha: include/asm/pci.h included from arch/alpha/kernel/setup.c
Message-ID: <20010521171854.A4121@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.15i
X-Operating-System: Linux air 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel 2.4.5-pre[34] don't compile on Alpha:

In incluse/asm-alpha/pci.h (include during compile of
arch/alpha/kernel/setup.c), there is

    150 static __inline__ int pci_controller_num(struct pci_dev *pdev)
    151 {
    152         struct pci_controller *hose = pdev->sysdata;
    153 
    154         if (hose != NULL)
    155                 return hose->index;
    156 
    157         return -ENXIO;
    158 }

which breaks on line 152:
In file included from arch/alpha/kernel/setup.c:52:
/usr/src/packages/linux-2.4.5-pre4/include/asm/pci.h: In function `pci_controller_num':
/usr/src/packages/linux-2.4.5-pre4/include/asm/pci.h:152: dereferencing pointer to incomplete type
make: *** [arch/alpha/kernel/setup.o] Error 1

MfG, JBG

-- 
Fehler eingestehen, Größe zeigen: Nehmt die Rechtschreibreform zurück!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-172-7608481 */
keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 8399 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)
