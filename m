Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263238AbVCKJVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbVCKJVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbVCKJVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:21:15 -0500
Received: from village.ehouse.ru ([193.111.92.18]:6917 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263238AbVCKJVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:21:06 -0500
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: linux-kernel@vger.kernel.org
Subject: mm/memory.c:97: bad pmd ... v2.6.11 amd64
Date: Fri, 11 Mar 2005 12:21:04 +0300
User-Agent: KMail/1.7.2
Cc: admin@list.net.ru
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111221.04497.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've just found following messages in dmesg of my smp
amd64 box. Is this a sign of broken hardware (box passed
memtest86 for 24 hours two months ago) or kernel problem?

mm/memory.c:97: bad pmd ffff81009773fc78(00002aaaaaaabab8).
mm/memory.c:97: bad pmd ffff81009773fc80(0000000000000003).
mm/memory.c:97: bad pmd ffff81009773fc88(00007ffffffffe3e).
mm/memory.c:97: bad pmd ffff81009773fc90(00007ffffffffe3f).
mm/memory.c:97: bad pmd ffff81009773fc98(00007ffffffffe40).
mm/memory.c:97: bad pmd ffff81009773fca8(00007ffffffffe41).
mm/memory.c:97: bad pmd ffff81009773fcb0(00007ffffffffe42).
mm/memory.c:97: bad pmd ffff81009773fcb8(00007ffffffffe43).
mm/memory.c:97: bad pmd ffff81009773fcc0(00007ffffffffe44).
mm/memory.c:97: bad pmd ffff81009773fcc8(00007ffffffffe45).
mm/memory.c:97: bad pmd ffff81009773fcd0(00007ffffffffe46).
mm/memory.c:97: bad pmd ffff81009773fcd8(00007ffffffffe47).
mm/memory.c:97: bad pmd ffff81009773fce0(00007ffffffffe48).
mm/memory.c:97: bad pmd ffff81009773fce8(00007ffffffffe49).
mm/memory.c:97: bad pmd ffff81009773fcf0(00007ffffffffe4a).
mm/memory.c:97: bad pmd ffff81009773fcf8(00007ffffffffe4b).
mm/memory.c:97: bad pmd ffff81009773fd00(00007ffffffffe4c).
mm/memory.c:97: bad pmd ffff81009773fd08(00007ffffffffe4d).
mm/memory.c:97: bad pmd ffff81009773fd10(00007ffffffffe4e).
mm/memory.c:97: bad pmd ffff81009773fd18(00007ffffffffe4f).
mm/memory.c:97: bad pmd ffff81009773fd20(00007ffffffffe50).
mm/memory.c:97: bad pmd ffff81009773fd30(0000000000000010).
mm/memory.c:97: bad pmd ffff81009773fd38(00000000078bfbff).
mm/memory.c:97: bad pmd ffff81009773fd40(0000000000000006).
mm/memory.c:97: bad pmd ffff81009773fd48(0000000000001000).
mm/memory.c:97: bad pmd ffff81009773fd50(0000000000000011).
mm/memory.c:97: bad pmd ffff81009773fd58(0000000000000064).
mm/memory.c:97: bad pmd ffff81009773fd60(0000000000000003).
mm/memory.c:97: bad pmd ffff81009773fd68(0000000000400040).
mm/memory.c:97: bad pmd ffff81009773fd70(0000000000000004).
mm/memory.c:97: bad pmd ffff81009773fd78(0000000000000038).
mm/memory.c:97: bad pmd ffff81009773fd80(0000000000000005).
mm/memory.c:97: bad pmd ffff81009773fd88(0000000000000009).
mm/memory.c:97: bad pmd ffff81009773fd90(0000000000000007).
mm/memory.c:97: bad pmd ffff81009773fd98(00002aaaaaaab000).
mm/memory.c:97: bad pmd ffff81009773fda0(0000000000000008).
mm/memory.c:97: bad pmd ffff81009773fdb0(0000000000000009).
mm/memory.c:97: bad pmd ffff81009773fdb8(0000000000417a40).
mm/memory.c:97: bad pmd ffff81009773fdc0(000000000000000b).
mm/memory.c:97: bad pmd ffff81009773fdc8(0000000000000065).
mm/memory.c:97: bad pmd ffff81009773fdd0(000000000000000c).
mm/memory.c:97: bad pmd ffff81009773fdd8(0000000000000065).
mm/memory.c:97: bad pmd ffff81009773fde0(000000000000000d).
mm/memory.c:97: bad pmd ffff81009773fde8(0000000000000198).
mm/memory.c:97: bad pmd ffff81009773fdf0(000000000000000e).
mm/memory.c:97: bad pmd ffff81009773fdf8(0000000000000198).
mm/memory.c:97: bad pmd ffff81009773fe00(0000000000000017).
mm/memory.c:97: bad pmd ffff81009773fe10(000000000000000f).
mm/memory.c:97: bad pmd ffff81009773fe18(00007ffffffffe37).
mm/memory.c:97: bad pmd ffff81009773fe30(7800000000000000).
mm/memory.c:97: bad pmd ffff81009773fe38(00000034365f3638).

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
