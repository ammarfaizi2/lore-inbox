Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316239AbSEWHeB>; Thu, 23 May 2002 03:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316260AbSEWHeA>; Thu, 23 May 2002 03:34:00 -0400
Received: from violet.setuza.cz ([194.149.118.97]:44039 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S316239AbSEWHeA>;
	Thu, 23 May 2002 03:34:00 -0400
Subject: Re: ipfwadm problems
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <017201c201ca$13054810$320e10ac@irvine.hnc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 23 May 2002 09:33:59 +0200
Message-Id: <1022139239.265.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-22 at 21:51, Kirk wrote:
> Does iptables have or allow IP Masqurading?  This is really what I'm trying
> to do as I have a network behind my linux server (acting as a router) and
> need to forward packets from 192.168.0.x to my WAN port on the same Linux
> server.  I had this working with ipchains until the upgrade to 2.4.18.
> 

Yes, You have to use the SNAT/DNAT targets in the PREROUTING/POSTROUTING
chains of the NAT table. Recognize, that IP Masquerade is nothing else
than a subset of Network Adress Translation (NAT).

Regards
Frank

BTW: A collegue of mine has the problem, that a host has 4 NICs; 2 to
the LAN and 2 to the internet. Packets coming from LAN NIC 1 shall be
forwarded through WWW NIC 1 and Packets from LAN NIC 2 through WWW NIC
2. Is there any way to perform this on a 2.2.x kernel using ipchains?
And even whorse; They need destination NAT in the reverse manner of the
above.


