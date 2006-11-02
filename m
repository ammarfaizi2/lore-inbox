Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752627AbWKBUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbWKBUkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbWKBUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:40:33 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:13134 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752627AbWKBUkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:40:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=FzNqRD3BQCpA27f7biZSh00GoaQSojhVtDjK4wYdeZAeLVlCw/5xfc7nzoOFDvazf1X4RFRX7ciAucr+DrPJRCAONOtoLvsp/oDsNpcbIcLlMtvl/NZF96F0oamTyU1hyhOqq66YwgNjLGeMCrWcTZpNkqOdUoJxuYA6MSGmSk8=  ;
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-usb-devel] [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Date: Thu, 2 Nov 2006 12:19:22 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       Randy Dunlap <randy.dunlap@oracle.com>, akpm@osdl.org,
       zippel@linux-m68k.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, link@miggy.org,
       Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       greg@kroah.com, toralf.foerster@gmx.de
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610311136.54058.david-b@pacbell.net> <20061101012346.GB27968@stusta.de>
In-Reply-To: <20061101012346.GB27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021219.27950.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 5:23 pm, Adrian Bunk wrote:

>         select MII if USB_NET_AX8817X!=n || USB_NET_MCS7830!=n

Thing is, I'm seeing that get morphed inside Kconfig to "select MII" in
some cases ... the "if x != n" gets ignored, MII can't be deselected.

That looks to me like a Kconfig dependency engine bug, so I'm just
noting it here rather than fixing it.  I guess it's not quite enough
of a Prolog engine ... ;)

- Dave

