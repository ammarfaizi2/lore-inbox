Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130747AbRAAEJ4>; Sun, 31 Dec 2000 23:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131397AbRAAEJq>; Sun, 31 Dec 2000 23:09:46 -0500
Received: from mailframe.cabinet.net ([213.169.1.9]:53262 "HELO
	mailframe.cabinet.net") by vger.kernel.org with SMTP
	id <S130747AbRAAEJg>; Sun, 31 Dec 2000 23:09:36 -0500
Date: Mon, 1 Jan 2001 05:39:08 +0200 (EET)
From: Jussi Hamalainen <count@theblah.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: path MTU bug still there?
In-Reply-To: <4.3.2.7.2.20010101114105.02922ef0@omega.cisco.com>
Message-ID: <Pine.LNX.4.30.0101010533390.12962-100000@shodan.irccrew.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, Lincoln Dale wrote:

> i know that you've said previously that you've increased your MTU beyond
> 1500, but can you validate that it is actually working?

Yup. At least 1500 byte ICMP echo packets get through the tunnel
OK.

> alternatively, ensure that your application is capable of enforcing a MSS
> <1460 if this is shown to not be the case ..

I found a way to work around this problem. I had to tell _ALL_
the hosts on my local network to use an MSS of 576 for the default
route (the GRE tunnel). Thus the packets always fit through without
fragmentation and the problem is gone (but not solved). If someone
has a more elegant solution, please tell me. This one seems to be
poison for the Windows boxes on my network. :I

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
