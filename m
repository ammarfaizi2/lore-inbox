Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277739AbRJRPNP>; Thu, 18 Oct 2001 11:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277740AbRJRPMy>; Thu, 18 Oct 2001 11:12:54 -0400
Received: from ip1-13.brfsodrahamn.se ([213.187.198.13]:55936 "HELO
	tuttifrutti.cdt.luth.se") by vger.kernel.org with SMTP
	id <S277739AbRJRPMo> convert rfc822-to-8bit; Thu, 18 Oct 2001 11:12:44 -0400
X-Mailer: exmh version 2.4 10/15/1999 with nmh-1.0.4
From: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Reply-To: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
To: linux-kernel@vger.kernel.org
Subject: Sound: opl3sa2 problem
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 18 Oct 2001 17:13:05 +0200
Message-Id: <20011018151310.BC82010DC9@tuttifrutti.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There seem to be a problem with the opl3sa2 driver with some
YMF chips. The driver does a test on some register bits that is
supposed to be read only. But they seem to be read/write in some
chip-versions and the test fails. I've commented out the "return 0;"
statement after the "opl3sa2: Control I/O port"... message and then
everything works as expected. This is with 2.4.12 but this problem
as been around for quite a while. The machine is a Toshiba Tecra 8000.

/Håkan
 
Oct 18 18:31:15 io kernel: ad1848/cs4248 codec driver Copyright (C) by Hannu 
Savolainen 1993-1996
Oct 18 18:31:15 io kernel: ad1848: No ISAPnP cards found, trying standard 
ones...
Oct 18 18:31:15 io kernel: opl3sa2: Control I/O port 0x370 is not a YMF7xx 
chipset!
Oct 18 18:31:15 io kernel: opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)

