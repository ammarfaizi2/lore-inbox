Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVCaFiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVCaFiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 00:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVCaFiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 00:38:14 -0500
Received: from web53903.mail.yahoo.com ([206.190.36.126]:13204 "HELO
	web53903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261999AbVCaFhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 00:37:45 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Kd1cdxoYD4jPXU8enAxy0l2x2UxD1XXk6CwXSXUCFrM3Bbv4pMMcwdW76pYCPTg6wGSgimx2YrnwPUwk7oKgH+tQUIhmfYDKSQs09hVO3+noH5Xw0QgOUJe9c3X2naOA6jPjjOvL+6pryz1r11faiD95g5OcRBv1rlDzZyOAnfY=  ;
Message-ID: <20050331053744.97435.qmail@web53903.mail.yahoo.com>
Date: Wed, 30 Mar 2005 21:37:44 -0800 (PST)
From: nobin matthew <nobin_matthew@yahoo.com>
Subject: HELP: PC104 IO card driver Problem
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friends,

Can anybody Help me in this Pc104 driver Problem;
What is the basics steps in doing read and write on
Pc104 cards.

Deatails Given Below:
              I am writing a Linux device driver for
Diamond systems
IR104 digital IO card. This is a PC104 bus device(that
means it ISA
bus compatible).
The Platform is Arcom Viper borad(with support for
PC104), This is a
Xscale, Little endian Platform.

The Specification of PC104 interface  given in Viper
borad manual is:
0x3C000000-0x3CFFFFFF PC/104 memory space(16MB)
0x30000000-0x300003FF PC/104 IO space(1KB)

Specification given in IR104 manual is:
I made the jumber setting so that, the IO space
addresses  taken by 8
registers will be 0x300-0x307

The driver should do read and write on this
registers(character device
driver).

I took two approaches one is:
i added IO space and 0x300, did inb() and oub().(IO
space base address
and 0x300)
otherway i did ioremap on added result, did inb() and
oub().

In the second method:
I did same procedures using IO memory space

both methods are giving errors, i think that is
related to paging. i think
there is a need for disabling paging in this space.

Please help regarding this. How to solve this.

Nobin Mathew



		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
