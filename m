Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316150AbSEJWdl>; Fri, 10 May 2002 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316151AbSEJWdk>; Fri, 10 May 2002 18:33:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:4654 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316150AbSEJWdj>;
	Fri, 10 May 2002 18:33:39 -0400
From: "Kosta Porotchkin" <kporotchkin@gmx.net>
To: "Linux Kernel mailing List \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: RE: PCI bus interrupts problem on dual Xeon SMP system
Date: Fri, 10 May 2002 17:30:00 -0600
Message-ID: <000f01c1f87b$40dbb150$a396a8c0@compaq12xl510a>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since no one has answer to my question, I wish to add some extra data.

>The system can boot from any bus, download and run the kernel.
>The problem is discovered during the root (NFS) file system mount
>(NFS server timeout, - looks like no interrupts are coming from
>the Ethernet card after kernel initialization).

The above assumption was checked by mounting the local file system. It is
true, no interrupts are coming from the Ethernet card inserted in slots ##
1,2,3,6 after kernel initialization.
It should be a kernel BUG, since the same card in same slot is working
before kernel starts (Etherboot is working excellent). In order to make a
fair comparison I tested the latest 2.5.15 kernel too (with acpismp=force).
The result was the same.

Again, it is Intel E7500 chipset, which seems to have some problems @ Linux.
I tried to search through this mail list, but did not find complaints about
missing PCI interrupts on this platform.

Any comments gurus can make?

Kosta

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.361 / Virus Database: 199 - Release Date: 5/7/2002


