Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRJDJwl>; Thu, 4 Oct 2001 05:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276480AbRJDJwb>; Thu, 4 Oct 2001 05:52:31 -0400
Received: from smtp2.cluster.oleane.net ([195.25.12.17]:33806 "EHLO
	smtp2.cluster.oleane.net") by vger.kernel.org with ESMTP
	id <S276468AbRJDJwR>; Thu, 4 Oct 2001 05:52:17 -0400
Date: Thu, 4 Oct 2001 11:52:36 +0200
From: Nicolas Mailhot <Nicolas.Mailhot@one2team.com>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] Symlinks broken on 2.4.10-ac[3-4] nfs
Message-ID: <20011004115236.A9373@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've found out much to my sorrow that the latest
ac's do not handle symlinks over nfs well.
For example, I get that kind of results :

lrwxrwxrwx    1 nim      cvs            92 oct  4 11:47
release.xml -> ../antbui
ld/init/release.xml?Q¿*U!±M~?Wè¢?0>Â%Ó?ª¯ô?ºªú]¡Úvä??®?§JO#b±?µøGé\?î1Ä?ü«B?´;??
ÐHT
lrwxrwxrwx    1 nim      cvs           387 oct  4 11:47 xml
-> ../antbuild/init/
xml£ú¢?ÛÕw?zê$ªEµ¶%Jº4­<?BÃÊY`L?è>=1Íî>Å?¹???§ÇÐ?ñú¸¬»??ÈÚ?¬q]?4ìG??Ã?´??è:»J]»ò
Ä?7¯ºËxxÍZ&?z³¬{??^¡9Lõ?|m?×©]?4?³iúÜ?NL·[#?|²ÕìcHh;û?r¤?$¤EÜI$íF?y???yíâ­?·??W9
m?1<FA?v*@KGü?Ü°¹dßl8?ì?íF°,óá&´l¾Ý¬ÈãS?ZÌ?¥M?iUi«b??c«âx.?Ðêýj?Êg?êf.f!ê?®pÊGêÆ
´??¾QÒAbwV1Û2áä1ÄL?QKè??ª?@¢Òaæà?Õ?±È??µ??,Å?u)ÉuRæ¶&T×Ï

after a 
[nim@ulysse ant]$ln -s ../antbuild/init/*xml .
[nim@ulysse ant]$ls -l

This is over an nfs mounted directory, server and client
2.4.40-ac4 nfs3, server-side fs : ext2

That's pretty ugly isn't it ?

-- 
Nicolas Mailhot
