Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130088AbQKDFHN>; Sat, 4 Nov 2000 00:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQKDFHD>; Sat, 4 Nov 2000 00:07:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:683 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129353AbQKDFGu>;
	Sat, 4 Nov 2000 00:06:50 -0500
Date: Fri, 3 Nov 2000 20:51:55 -0800
Message-Id: <200011040451.UAA13833@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: phil@fifi.org
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <87u29oz93z.fsf@tantale.fifi.org> (message from Philippe Troin on
	03 Nov 2000 19:53:04 -0800)
Subject: Re: 2.2.x BUG & PATCH: recvmsg() does not check msg_controllen correctly
In-Reply-To: <87n1fgvl7a.fsf@tantale.fifi.org>
 <200011032218.OAA12790@pizda.ninka.net> <878zr0vbda.fsf@tantale.fifi.org>
 <200011040038.QAA13178@pizda.ninka.net> <87u29oz93z.fsf@tantale.fifi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Philippe Troin <phil@fifi.org>
   Date: 03 Nov 2000 19:53:04 -0800

   Yes I agree, mixing signed and unsigned arithmetic is evil... Doesn't
   gcc have a flag for unsafe signed/unsigned mixtures ?

   Would you consider this patch (or a variant) for inclusion ?

I would accept a patch which made the code set fdmax <= 0 when
(msg->msg_controllen < (sizeof(struct cmsghdr) + sizeof(int)))
because it is the sole reason this bug exists at all.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
