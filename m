Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSG3PQR>; Tue, 30 Jul 2002 11:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSG3PQR>; Tue, 30 Jul 2002 11:16:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318295AbSG3PQR>;
	Tue, 30 Jul 2002 11:16:17 -0400
Date: Tue, 30 Jul 2002 16:19:40 +0100
From: Matthew Wilcox <willy@debian.org>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Matthew Wilcox <willy@debian.org>, Russell King <rmk@arm.linux.org.uk>,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020730161940.P1441@parcelfarce.linux.theplanet.co.uk>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk> <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk> <008801c237d6$8b7dc640$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <008801c237d6$8b7dc640$294b82ce@connecttech.com>; from stuartm@connecttech.com on Tue, Jul 30, 2002 at 10:36:51AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 10:36:51AM -0400, Stuart MacDonald wrote:
> I don't know if reclaiming the USB major is a good idea or not.

It's not _all_ of USB, just:

166 char        ACM USB modems
                  0 = /dev/ttyACM0      First ACM modem
                  1 = /dev/ttyACM1      Second ACM modem
                    ...

167 char        ACM USB modems - alternate devices
                  0 = /dev/cuacm0       Callout device for ttyACM0
                  1 = /dev/cuacm1       Callout device for ttyACM1
                    ...

188 char        USB serial converters
                  0 = /dev/ttyUSB0      First USB serial converter
                  1 = /dev/ttyUSB1      Second USB serial converter
                    ...

189 char        USB serial converters - alternate devices
                  0 = /dev/cuusb0       Callout device for ttyUSB0
                  1 = /dev/cuusb1       Callout device for ttyUSB1
                    ...

216 char        USB BlueTooth devices
                  0 = /dev/ttyUB0               First USB BlueTooth device
                  1 = /dev/ttyUB1               Second USB BlueTooth device
                    ...

217 char        USB BlueTooth devices (alternate devices)
                  0 = /dev/cuub0                Callout device for ttyUB0
                  1 = /dev/cuub1                Callout device for ttyUB1
                    ...

I think you were confused with char major 180 which has
printers/mice/scanners/etc on it.

-- 
Revolutions do not require corporate support.
