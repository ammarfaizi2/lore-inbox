Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285394AbRLNPgt>; Fri, 14 Dec 2001 10:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285398AbRLNPgi>; Fri, 14 Dec 2001 10:36:38 -0500
Received: from [208.248.202.76] ([208.248.202.76]:62980 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id <S285394AbRLNPgX>;
	Fri, 14 Dec 2001 10:36:23 -0500
Date: Fri, 14 Dec 2001 09:37:04 +0100
From: root <ngustavson@emacinc.com>
To: linux-kernel@vger.kernel.org
Subject: copy_to_user count seg-fault
Message-ID: <20011214093704.C376@nate>
Reply-To: root <ngustavson@emacinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Balsa 0.6.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a device driver for a 2.4.14 kernel.

In my standard read function I use copy_to_user(buff,&reloc,count);
buff is the buffer passed from the read function, reloc is a char, and 
count is the size_t count paramenter from the read function.

as long as I pass it count it works fine, however if I replace count 
with a constant 1 I get a seg fault.

if I set count=1 I get a seg fault.

and finally and weirdest of all, if I do an if(count==1) I get a seg 
fault.

has anyone seen anything like this before, what could possibly be 
causing this?


