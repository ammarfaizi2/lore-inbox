Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129192AbQKJK7x>; Fri, 10 Nov 2000 05:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKJK7o>; Fri, 10 Nov 2000 05:59:44 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:64264 "HELO
	atlantis.hlfl.org") by vger.kernel.org with SMTP id <S129192AbQKJK71>;
	Fri, 10 Nov 2000 05:59:27 -0500
Date: Fri, 10 Nov 2000 11:59:25 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001110115925.A16777@profile4u.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 10, 2000 at 03:07:21AM +0000
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Le Fri, Nov 10, 2000 at 03:07:21AM +0000, Alan Cox a écrit:
> Anything which isnt a strict bug fix or previously agreed is now 2.2.19
> material.

Compiling 2.2.18pre21 without sysctl gives an error at linkage:
kernel/kernel.o(__ksymtab+0x608): undefined reference to `sysctl_jiffies'

trivial patch included, not sure it's the right one.

	Arnaud.

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff-ksyms

--- linux/kernel/ksyms.old	Fri Nov 10 11:58:20 2000
+++ linux/kernel/ksyms.c	Fri Nov 10 11:58:24 2000
@@ -284,7 +284,6 @@
 EXPORT_SYMBOL(register_sysctl_table);
 EXPORT_SYMBOL(unregister_sysctl_table);
 EXPORT_SYMBOL(sysctl_string);
-EXPORT_SYMBOL(sysctl_jiffies);
 EXPORT_SYMBOL(sysctl_intvec);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_dointvec);

--ZGiS0Q5IWpPtfppv--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
