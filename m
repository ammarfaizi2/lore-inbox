Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRBSPho>; Mon, 19 Feb 2001 10:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129554AbRBSPhe>; Mon, 19 Feb 2001 10:37:34 -0500
Received: from lucifer.kgt.bme.hu ([152.66.4.2]:24324 "EHLO lucifer.kgt.bme.hu")
	by vger.kernel.org with ESMTP id <S129283AbRBSPhQ>;
	Mon, 19 Feb 2001 10:37:16 -0500
Date: Mon, 19 Feb 2001 15:37:00 +0000 (GMT)
From: Felvegi Peter Andras <petschy@lucifer.kgt.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: can i change the ip masq ports?
Message-ID: <Pine.LNX.4.10.10102191536310.2119-100000@lucifer.kgt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

 i've run to the following problem recently: i had to install ip masq to
a server to provide inet access for the computers on the lan. it didn't
work, i spent a few days with it browsing the howto, configuring the
firewall, etc.
 at the end it turned out, that the evil isp filters the packets. i
figured out that this is only possible through watching the port numbers
in the packets. i made a fast hack in include/ipmasq.h to start the ip
masq ports not from 61... but from a number not much above 1024. 
 this cured the problem, now the masq runs flawlessly, though there's
not much traffic on the server beside the masq.  my question: is it
possible that this simple hack will cause collisions with other
modules/programs that allocate ports? in the masq sources i haven't
found any check for that, probably because the original port region was
allocated uniquely for masq. so i think the collision is possible.
 please comment on this. it would be nice to have the server run ip masq
reliably. please cc any answers to me, since i'm not on the list
(yet;)).

							cheers; petschy


