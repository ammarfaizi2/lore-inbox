Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280320AbRKERnE>; Mon, 5 Nov 2001 12:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281256AbRKERmy>; Mon, 5 Nov 2001 12:42:54 -0500
Received: from conn.mc.mpls.visi.com ([208.42.156.2]:21640 "EHLO
	conn.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id <S280320AbRKERmo>; Mon, 5 Nov 2001 12:42:44 -0500
Date: Mon, 5 Nov 2001 11:42:43 -0600
From: Ryan Hayle <hackel@walkingfish.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor IDE performance with VIA MVP3
Message-ID: <20011105114242.A8099@isis.visi.com>
In-Reply-To: <20011105005033.A10060@isis.visi.com> <01110516120000.00794@nemo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01110516120000.00794@nemo>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Nov 05, 2001 at 04:12:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov, 2001 at 04:12:00PM +0000, vda wrote:
> Are you saying that hdparm -T -t is yielding wildly varying results?
> Looks similar to failing hd symptoms or bug in IDE layer causing retries
> after error/timeout. What's in the logs?

hdparm -T (buffer-cache reads) gives good numbers, 43v69 M/sec just
now.  But that's only mesuring reading from the drive's 2M cache (I
believe?).  It is the hdparm -t test (buffered disk reads) that is the
problem.  As I said, I don't receive any errors or retries
whatsoever.  Everything seems to be working perfectly, just very, very
slow...

> Well, I had problems with drives refusing to do [u]dma.
> On my home machine I found out that compiling kernel with support for VIA 
> chipset allowed udma to work ok (hdparm -T -t = ~20mb/s). Without that 
> support, my hd was stuck in pio, ~6mb/s.

That's the thing--it claims to be in UDMA mode, and again I get no
errors.  Even when I do 'hdparm -d1 -X66 /dev/hda", everything works fine,
without errors, only the speed problems persist.  Oh, and I have compiled
my kernel with VIA IDE support, it makes no difference in the performance.

It's sounding more and more like this isn't a driver/chipset problem, but
something wrong with the HD itself.  Thanks for your insight.

Ryan
