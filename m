Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283392AbRK2VMo>; Thu, 29 Nov 2001 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283391AbRK2VMf>; Thu, 29 Nov 2001 16:12:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7412
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283397AbRK2VMU>; Thu, 29 Nov 2001 16:12:20 -0500
Date: Thu, 29 Nov 2001 13:12:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16 revisited
Message-ID: <20011129131212.C496@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	"Nathan G. Grennan" <ngrennan@okcforum.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1006928344.2613.2.camel@cygnusx-1.okcforum.org> <3C05D608.6D06190D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C05D608.6D06190D@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 10:30:32PM -0800, Andrew Morton wrote:
> "Nathan G. Grennan" wrote:
> > 
> > Well I tried your patch Andrew. It seemed to have absolutely no effect
> > on my problem. I used the am-response.patch someone posted the url to
> > eariler in the first thread, which was just a file of your patch. I
> > really suggest you try a mozilla source rpm. Not only does it do the
> > unarchiving, but also patches and rm -rf. I often see a second pause
> > during the patching after the unarchving. I use
> > 
> > rpm --rebuild mozilla-2001112602_trunk-0_rh7.src.rpm
> > 
> > I also tried Redhat's latest rawhide kernel, 2.4.16-0.1 and it had to
> > had time same problem. So it isn't fixed by one of their patchs. It is
> > most likely just a difference between Linus's 2.4.9 and 2.4.16.
> 
> Nathan,
> 
> I can reproduce the 30 second stall on ext3.  It is due to

Just recently I had to run badblocks -ws on a scsi hard drive.  It was on
its own scsi controller.  During the write portions, I was able to see
pauses of 1-5 seconds.  Mouse didn't move, nothing.  During the read
(compare) portion, there were no such pauses.

This was on vanilla 2.4.16. 2x366 celeron, and 256MB ram.  Only reading with
mutt, and irc.  gkrellm showed the pauses.

00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
00:08.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
00:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] AGP (rev 01)

mf
