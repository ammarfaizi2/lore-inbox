Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292635AbSCDSPr>; Mon, 4 Mar 2002 13:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292648AbSCDSPe>; Mon, 4 Mar 2002 13:15:34 -0500
Received: from florence.ie.alphyra.com ([193.120.224.170]:44686 "EHLO
	florence.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S292639AbSCDSPZ>; Mon, 4 Mar 2002 13:15:25 -0500
Date: Mon, 4 Mar 2002 18:14:47 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.dub.ie.alphyra.com
To: Stevie O <stevie@qrpff.net>
cc: erich@uruk.org, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: <5.1.0.14.2.20020302200004.01da4790@whisper.qrpff.net>
Message-ID: <Pine.LNX.4.44.0203041810240.11394-100000@dunlop.dub.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Stevie O wrote:

> ipchains -a input -i eth0 -d ! 66.92.237.176 -j DENY -l
> 
> With iptables i'd need that on both the INPUT *and* FORWARD rules...

create a 'filter' chain, attach it to INPUT -i eth0 and FORWARD -i 
eth0.

maintain your 'filter' chain and you have the same as ipchains, but 
with more flexibility for when you /do/ want rules to apply only to 
local applications.

--paulj

