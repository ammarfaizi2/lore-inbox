Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316699AbSEQV6d>; Fri, 17 May 2002 17:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSEQV6c>; Fri, 17 May 2002 17:58:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:12691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316699AbSEQV6b>;
	Fri, 17 May 2002 17:58:31 -0400
From: "Kosta Porotchkin" <kporotchkin@gmx.net>
To: "Linux Kernel mailing List \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Intel NIC driver and SIOCGMIIPHY? (Warning! maybe stupid question!)
Date: Fri, 17 May 2002 16:48:44 -0600
Message-ID: <000101c1fdf6$7c92c460$a396a8c0@compaq12xl510a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to access Intel NIC (10/100) internal data using ioctl () with
SIOCGMIIPHY and SIOCDEVPRIVATE command parameters (the kernel is 2.4.18 with
some patches). The SIOCGMIIPHY does not passed to the driver, while the
SIOCDEVPRIVATE  does. Why?
In the original Intel driver (e100) there is no case for SIOCDEVPRIVATE in
e100_ioctl(), so this access method is not working. The eepro100 driver has
the same case for both these commands (in speedo_ioctl()), so it works. Is
this problem caused by kernel itself?
What is interesting, that the Intel Gigabit NIC Linux driver (e1000) does
not allow access to internal registers at all.

Thanks
Kosta

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.361 / Virus Database: 199 - Release Date: 5/7/2002


