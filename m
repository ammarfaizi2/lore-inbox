Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRIDVRN>; Tue, 4 Sep 2001 17:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269372AbRIDVRD>; Tue, 4 Sep 2001 17:17:03 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:14854 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S269354AbRIDVQr>; Tue, 4 Sep 2001 17:16:47 -0400
Message-ID: <3B9544E2.654F3945@netvision.net.il>
Date: Wed, 05 Sep 2001 00:17:22 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tim Waugh <twaugh@redhat.com>
Subject: Re: lpr to HP laserjet stalls
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com> <3B94B93B.2B907DCF@netvision.net.il> <20010904122751.S20060@redhat.com> <3B94D58B.180860A2@netvision.net.il> <20010904142755.V20060@redhat.com> <3B94DA02.9F6E9184@netvision.net.il> <20010904144814.W20060@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Tue, Sep 04, 2001 at 04:41:22PM +0300, Michael Ben-Gershon wrote:
> 
> > Building it as a module meant I didn't have to reboot for every time
> > I wanted to retest it with different parameters.
> 
> I understand.  But I'm looking at the differences between a broken
> system and a working system.  It seems from what you say to be:
> 
> - CONFIG_PARPORT_PC_FIFO
> - Parport built as modules
> 
> So it seems as though it's either one of these, or the combination.

The modules side could possibly be explained by a possible h/w clash, with
the printer support loaded later than something which it may be clashing
with if loaded first - although I am a bit out of my depth in terms of
my understanding of the kernel boot process here. However, what is
interesting is that I originally had the problems when I upgraded to
the 2.4 kernel (and RH 7.1). I subsequently upgraded the h/w from a
PII 333 on a Tyan m/b to a P4 1.5G on an Asus m/b. The former was a mixed
PCI/ISA board, with both types of cards installed, whereas the latter
was all PCI. I had the same printer problem on both boards with kernel 2.4,
which makes the possibility of a h/w clash being the cause a bit remote.

The 2 changes above (I have not yet had a chance to try each in isolation)
fixed the problem.

Michael Ben-Gershon
mybg@netvision.net.il
