Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264191AbRFNXg1>; Thu, 14 Jun 2001 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264196AbRFNXgS>; Thu, 14 Jun 2001 19:36:18 -0400
Received: from www.transvirtual.com ([206.14.214.140]:47120 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S264191AbRFNXgC>; Thu, 14 Jun 2001 19:36:02 -0400
Date: Thu, 14 Jun 2001 16:35:37 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "David S. Miller" <davem@redhat.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: VGA handling was [Re: Going beyond 256 PCI buses]
In-Reply-To: <15145.14057.67940.752173@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10106141616470.12951-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The secondary VGA devices are only interesting to things like the X
> server, and xfree86 does all the enable/disable/bridge-forward-vga
> magic when doing multi-head.

   Actually this weekend I'm working on this for the console system. I
plan to get my TNT card and 3Dfx card both working at the same time both in
VGA text mode. If you also really want to get multiple card in vga text
mode it is going to get far more complex in a multihead besides the
problem of multiple buses.

   First the approach I'm taking is be able to pass to vgacon different
register and memory regions as well as different layouts for vga text
mode. Different cards have different memory layouts for vga text mode. I
discovered this the hard way :-( This way I can get these VGA regions from
the pci bus and pass this to vgacon. This approach will solve alot of
problems. We still havethe problem of multibuses which I haven't yet
figured out. 


