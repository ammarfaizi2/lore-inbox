Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285389AbRLSQid>; Wed, 19 Dec 2001 11:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285388AbRLSQiW>; Wed, 19 Dec 2001 11:38:22 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:43904 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S285385AbRLSQiN>; Wed, 19 Dec 2001 11:38:13 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: IDE Harddrive Performance
Date: Wed, 19 Dec 2001 17:38:11 +0100
Organization: Internet Factory AG
Message-ID: <3C20C273.27456055@internet-factory.de>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1008779891 30918 195.122.142.158 (19 Dec 2001 16:38:11 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 19 Dec 2001 16:38:11 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /dev/hdc:
>  Timing buffered disk reads:  64 MB in  5.63 seconds =3D 11.37 MB/sec

Thats low. I get 25.5 MB/sec from my old Maxtor 96147U8 on a P2L97-DS
(this was Maxtors first 60 gig drive - 8 heads, 15 gig per platter -
yours has 3 heads with 40 gigs per platter. the higher recording density
should make it even faster than mine).

But: This is still more than my IBM DTLA does on that board - which in
itself is perfectly capable of 36 MB/sec when driven with UDMA 100, but
drops to approx. 22 MB/sec when limited to UDMA33. So your drive might
have a similar issue. Its nominal transfer rate is higher than UDMA 33
can deliver, and it wastes bandwidth in adapting to the slower bus.

Holger
