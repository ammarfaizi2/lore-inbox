Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265638AbTFNHtn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTFNHtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:49:42 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:40874 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S265638AbTFNHti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:49:38 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Bernhard Kaindl" <bk@suse.de>, <bojan@gajba.net>
Cc: <linux-kernel@vger.kernel.org>, "Bernhard Kaindl" <bernhard.kaindl@gmx.de>
Subject: RE: ptrace/kmod local root exploit STILL unresolved in 2.4.21! - MY MISTAKE
Date: Sat, 14 Jun 2003 09:03:30 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAMEDNEFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.56.0306140027190.20048@wotan.suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

 >>> I've upgraded my Linux box to 2.4.21 because of the security
 >>> reasons. Now I found out that old local exploit for ptrace
 >>> is still working under 2.4.21. Wasn't it fixed in RC1?

 >> I've tested this exploit in wrong way. I've first logged in as 
 >> root, then I made "su nobody" and then exploit worked.

 > Maybe "nobody" isn't a "real" user in your case. If there is some
 > problem with it, you may end up with uid 0 after "su nobody".
 >
 > check the output of the command "id" after the executing the su
 > command, just to be safe in any case!
 >
 > If su really worked correctly, the exploit may not even work if
 > you su (successfully) su'ed from root.

Probably more to the point, the command `su nobody` does NOT log you
in as user nobody. You need the command `su -l nobody` to do that.
Check the manpage for su to verify that without the -l option, you
are still logged in as user root although you are running with the
effective user nobody.

My understanding is that the permissions checks can succeed when
EITHER your login or effective user would succeed in most cases,
but in some cases, it's when your login user succeeds irrespective
of whether your effective user would succeed or not.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.488 / Virus Database: 287 - Release Date: 5-Jun-2003

