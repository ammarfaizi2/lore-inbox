Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289380AbSAJKgu>; Thu, 10 Jan 2002 05:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289381AbSAJKgl>; Thu, 10 Jan 2002 05:36:41 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:29191 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289380AbSAJKge>; Thu, 10 Jan 2002 05:36:34 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15421.27446.227873.475829@laputa.namesys.com>
Date: Thu, 10 Jan 2002 13:21:42 +0300
To: "Weiping He" <laser@zhengmai.com.cn>
Cc: "Oleg Drokin" <green@Namesys.COM>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@Namesys.COM>
Subject: Re: anybody know about "journal-615" and/or "journal-601" log error?(may be SCSI problem?)
In-Reply-To: <003b01c1997c$4a86fec0$d20101c0@T21laser>
In-Reply-To: <005401c18dc6$f3e3fb10$d20101c0@T21laser>
	<20011226094209.B871@namesys.com>
	<003b01c1997c$4a86fec0$d20101c0@T21laser>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

journal-601 means that writing of the block into the journal area failed.
journal-615 means that writing of the commit record into the journal area failed.

Reiserfs cannot work reliably if there are io errors on access to
journal area. So, if this is turns out to be hardware problem (as it
looks to be, judging by scsi error messages), you will have to resort to
changing drive. There is also not well tested support for relocating
journal to another device or different place on a device.

Weiping He writes:
 > Hi,
 > 
 > I've experienced another crash this morning.
 > I'v recorded the message displayed on the screen:
 > 
 > -------------------------------------8<------------------------------------------------
 > journal-601, buffer write failed

Nikita.
