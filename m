Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbQKQPsc>; Fri, 17 Nov 2000 10:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbQKQPsW>; Fri, 17 Nov 2000 10:48:22 -0500
Received: from adsl-216-63-56-125.dsl.stlsmo.swbell.net ([216.63.56.125]:11273
	"EHLO dublin.innovates.com") by vger.kernel.org with ESMTP
	id <S129469AbQKQPsJ>; Fri, 17 Nov 2000 10:48:09 -0500
X-OpenMail-Hops: 1
Date: Fri, 17 Nov 2000 09:17:56 -0600
Message-Id: <H00000650001a074.0974474275.dublin.innovates.com@MHS>
Subject: RE: Re: 2.2.18pre21 - IP kernel level autoconfiguration
MIME-Version: 1.0
From: (Chip Schweiss) chip@innovates.com
TO: luca.montecchiani@teamfab.it
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline; filename="BDY.TXT"
	;Creation-Date="Fri, 17 Nov 2000 09:17:56 -0600"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem seems to be deeper than that.  I first encountered the 
problem with only bootp compiled in.  In my configuration I am not able 
to supply kernel parameters on the client which may be why you were 
able to get bootp to execute.

Chip



> It seem somewhere between 2.2.17 and the current 2.2.18 kernel, IP 
> kernel level autoconfiguration has been broken. Upon kernel loading 
> the Ethernet card is detected and loaded properly, but the bootp code 
> never seems to be executed and mounting the root partion via NFS then 
> fails from lack of IP configuration. 
> I haven't had any luck tracing down the root of this problem. 
> Anyone else experience this problem or have a patch to fix it? 

Hi!

I've the same behavior here:

 server kernel : 2.2.17
 dhcpd         : 2.0b1pl29
 client kernel : 2.2.18-21
 client cmdline: root=/dev/nfs nfsroot=/foo/bar ip=bootp

After some quick tests seem that if you want bootp
you _need_ to compile the client's kernel with _only_ bootp,
if you have also dhcp, it doesn't work :(

Dhcp into kernel is COOL and I hope that someone is
porting on 2.4 ;), doesn't seem that hard

hope this help,
luca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
