Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbULAOGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbULAOGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbULAOGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:06:10 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:46297 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261259AbULAOGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:06:04 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 tcp problems
Date: Wed, 1 Dec 2004 14:11:32 +0000
User-Agent: KMail/1.6.1
Cc: kernel <kernel@nea-fast.com>
References: <41AB7C2C.3070505@nea-fast.com>
In-Reply-To: <41AB7C2C.3070505@nea-fast.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200412011411.32124.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.100; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Stephen Hemminger wrote:
> > On Mon, 29 Nov 2004 13:03:34 -0500
> >
> > kernel <kernel@nea-fast.com> wrote:
> >> I've run into a problem with 2.6.(8.1,9) after installing a secondary
> >> firewall. When I try to pull data through the original firewall
> >> (mail, http, ssh), it stops after approx. 260k. Running ethereal
> >> tells me "A segment before the frame was lost" followed by a bunch
> >> of  "This is a TCP duplicate ack" when using ssh. All 2.4.x machines
> >> and windows clients work fine. I built 2.4.28 and it works fine from
> >> my machine. I also fiddled with tcp_ecn and that didn't fix it
> >> either. I don't have any problems communicating to "local" machines.
> >> I've attached the tcpdump output from an scp attempt. NIC is a 3Com
> >> Corporation 3c905B.
> >
> > What kind of firewall?  There are firewalls that are too stupid and don't
> > understand TCP window scaling.
>
> It's a fortigate 60.  We put our secure web servers behind a netscreen 5
> firewall which plugs into the fortigate and that's when the problems
> started.  I remember reading some stuff on lkm about recent tcp changes
> but I couldn't remember exactly what it was. Thanks for reminding me !
>
> Here is how it's layed out now
> secure_web_servers->netscreen->fortigate->rest_of_network
>

Not sure if this helps:

I have a pair of Dell PowerEdge 1750's (running Mandrake 9.2/2.4.22) plugged 
directly into a Netscreen 5GT and they do not exhibit this behaviour.

Network cards are bcm5700 series.

/proc/sys/net/ipv4/tcp_window_scaling is set to '1'

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBrdEUBn4EFUVUIO0RAv6VAJ4+sdb3orBiFByfFWbXg40DbA1yygCff8qq
yAF7xiYh75Fi3JU8NnaaVFs=
=nMI1
-----END PGP SIGNATURE-----
