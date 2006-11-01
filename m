Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423639AbWKABol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423639AbWKABol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423644AbWKABol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:44:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:63551 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423639AbWKABok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:44:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZgiuTEpFwoLmwaCTGKliDGE60jtRpG9CWh6oHrf2XatbW4cZCpemEeFzQIauaGUtEYVLDkqUjT6BhpAlbWXSNWSJarm4fwUJ0Q4+Che4KA0a99XCTpn9NR3aBI8mnPzyhw4KU/yfUJkeKqkFaC3ND38xP4MHGJRpk5VQ0HuqEzw=
Message-ID: <aaf959cb0610311744w2a9aa7a8o9d38cf957e52bcf1@mail.gmail.com>
Date: Wed, 1 Nov 2006 09:44:38 +0800
From: "zhou drangon" <drangon.mail@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: reiser4 panic
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

I try reiser4 and got a kernel panic.

I use kernel 2.6.19-rc3-mm1, config kernel to enable reiser4,
then I use reiser4progs-1.0.5 to excute following command,

mkfs.reiser4 /dev/hda5
mount -t reiser4 /dev/hda5 /hda5
cd /hda5
mkdir FC6_mirror
nohup wget -m -np -nH --cut-dirs=3 -R *-debuginfo-*
ftp://ftp.nara.wide.ad.jp/pub/Linux/fedora/core/updates/6/i386/ &
nohup wget -m -np -nH --cut-dirs=3 -R *-debuginfo-*
ftp://ftp.kddilabs.jp/Linux/packages/fedora/core/updates/6/x86_64/ &

then I make a link at $wwwroot/html/Fedora to /hda5/FC6_mirror
my web server is apache 2.2.3, use worker mpm,

when I use web browser to access the Fedora mirror
http://<myip>/Fedora/core/update/6/i386/
download the rpm files if fine.

until I try to access one file
http://<myip>/Fedora/core/update/6/i386/repodata/repomd.xml
the kernel panic.

this file's size is 1197 bytes, a common file.

the infomation print on the screen is something like :
kernel panic, at reiser4/plugin/item/tail.c:426

I reformat the partition and try again, the bug can reproduced.

any idea?

Best regards!

drangon
2006-11-01
