Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWCEViF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWCEViF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWCEViF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:38:05 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:35270 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751824AbWCEViD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:38:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3ekL1ekpF6mWqQL4JxMADBwWdC2TpAdzYoCW2PNawv+JtS+LcyP6oSJMxZr644YADHpGoQknEvbY3IaIVCusJOozuASRZ2YRXpYTajvSmvJLL66HozG/EbNCuehytj98tPPY7MPg6pHTeda8WvIkMX2mEFPA6gNuliIhBcAcbI=
Message-ID: <9a8748490603051338u5a182b53w4cd9c349c0ceee1b@mail.gmail.com>
Date: Sun, 5 Mar 2006 22:38:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Joel Bryan T. Juliano" <joelbryan.juliano@gmail.com>
Subject: Re: Network Communication between "eth0" and "dhcp", only last for 1 minute. On NIC Vendor: Davicom Semiconductor, Inc. Device: 21x4x DEC-Tulip compatible 10/100 Ethernet. NIC Bus Type: PCI
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1141499915.5874.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1141499915.5874.2.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/06, Joel Bryan T. Juliano <joelbryan.juliano@gmail.com> wrote:
> My DHCP is up and running, I have no problems acquiring IP address
> during boot. I can connect to the internet, but for just under 1 minute.
>
> I had experimented with the commands for reloading the network (ifdown
> eth0, ifup eth0, /etc/init.d/networking restart, dhclient), reacquiring
> DHCP and manually bringing it up, or use static IP to connect to my DSL
> modem.
> My DSL modem is ZyXel Prestige 600 Series DSL Router. I even kill
> running dhclient, dhcbdb (NetworkManager), and NetworkManager. And route
> the gateway manually, but even without DHCP, my connection disconnects
> after 1 minute.
>
> For the first few seconds, I can ping my Gateway/Router/DHCP server,
> until 1 minute elapse, then it disconnects. Then after 1 minute elapse I
> try to run dhclient and it does not work anymore this point.
>
> To bring up the network again, I manually unplugging and re-plugging the
> network cable. Then it works again, for just 1 minute.
>
> I fixed it using mii-diag, with -r option to resets autonegotiation,
>

I've seen a lot of NIC/Switch combinations over the years that don't
work properly with autonegotiation. Try forcing the card to 100mbit
full-duplex and then do the same on the switch  so both ends are
forced to the proper speed/duplex setting instead of relying on
autoneg.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
