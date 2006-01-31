Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWAaN3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWAaN3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWAaN3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:29:40 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:50873 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750808AbWAaN3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:29:39 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 Jan 2006 14:27:36 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DF65C8.nail3B41650J9@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <mj+md-20060131.104748.24740.atrey@ucw.cz>
In-Reply-To: <mj+md-20060131.104748.24740.atrey@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> > What Linux does is to artificially prevent this view to been seen from outside the
> > Linux kernel, or to avoid integrating a particular device into a unique SCSI
> > driver system although it would be apropriate.
>
> How exactly does Linux prevent this???

By not treating ATAPI the same as all other SCSI devices.


> > Users like to be able to get a list of posible targets for a single protocol.
> > Nobody would ever think about trying to prevent people from getting a unified
> > view on the list possible hosts that talk TCP/IP.
>
> How do you perform -scanbus for TCP/IP? :-)

There are various programs that do that for you.
You could e.g. send a ping to the broadcast address in order to find hosts
that are on the local network.


> > In addition, nobody would ever think about implementing a separate TCP/IP stack 
> > for network interfaces that are PPP connections via a modem vs. network 
> > interfaces that go via a Ethernet adaptor. Nobody would ever try to convince
> > me that you could save code in the kernel by avoiding the usual network stack 
> > as a specific machine may not have Ethernet but a Modem connection only.
>
> There is an interesting similarity: in the TCP/IP stack, you also shouldn't
> assume anything about names of network interfaces, they are just opaque
> identifiers (in many times assigned by the administrator, not by the kernel).
> The right way of addressing is by IP addresses or DNS names, which is
> pretty similar to the addressing of SCSI devices on Linux, isn't it?

If you understand this, why then insists other people in using names like 
/dev/hd*?



> Scanning for all available CD burners is of course a nice feature, but
> I don't think it should be implemented by asking all existing SCSI-like
> devices if they are a CD burner (for example because there can be an
> almost infinite number of them, given that you can do SCSI-over-IP
> and other similar tricks). The problem of presenting devices to the

And while this kind of scanning works in case that you have all devices 
integrated inside a single SCSI implementation, it does not work for ATAPI
because someont artificially decided to exclude one single SCSI transport 
from the global view.

And regarding iSCSI, If you like to talk to such a device, you need to 
authentificate first. This is typically done by the kernel that in turn
trnaferres the remote iSCSI device into a virtual local SCSI device.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
