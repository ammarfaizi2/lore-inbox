Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDDUPb>; Wed, 4 Apr 2001 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132137AbRDDUPV>; Wed, 4 Apr 2001 16:15:21 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:27652 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132124AbRDDUPN>; Wed, 4 Apr 2001 16:15:13 -0400
Message-ID: <3ACB8098.DFEC12D7@vc.cvut.cz>
Date: Wed, 04 Apr 2001 13:14:16 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Wade Hampton <whampton@staffnet.com>
CC: Carsten Langgaard <carstenl@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com> <3ACB3CA5.D978EF41@staffnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wade Hampton wrote:
> 
> Carsten Langgaard wrote:
> >
> > I'm not sure what the problem is, but the whole deal about checking whether the
> > controller runs in 16 bit or 32 bit mode, is a little bit tricky.
> >[snip]
> Without the changes listed in this thread, 2.4.3 crashed vmware 2.0.3
> Linux. It did not OOPS the kernel, it caused vmware to go down in
> flames....  Changing the code per the previous mail fixed it and
> my VM now works fine.  THANKS!
> 
> Is this list non-causal?  The answer was posted to the list as I
> was getting ready to build 2.4.3 on my VM, before I found the
> problem or even had to ask the question!

VMware is working on implementation PCnet 32bit mode in emulation (there
is no such thing now because of no OS except FreeBSD needs it). But
my question is - is there some real benefit in running chip in
32bit mode? All registers except CSR88 use only low 16 bits anyway,
so is 32bit mode needed for bigendian ports, or what's reasoning
behind it? AFAIK all chips support 16bit mode, and having only 16bit
mode in code could save at least one indirect jump on each chip access.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
