Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282880AbRLVWci>; Sat, 22 Dec 2001 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282896AbRLVWcU>; Sat, 22 Dec 2001 17:32:20 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:19986 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S282880AbRLVWb6>;
	Sat, 22 Dec 2001 17:31:58 -0500
Date: Sat, 22 Dec 2001 17:05:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>,
        linux-kernel@vger.kernel.org, large-discuss@lists.sourceforge.net,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, rusty@rustcorp.com.au
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Message-ID: <20011222170552.C117@elf.ucw.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D814@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D814@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > From: Pavel Machek [mailto:pavel@suse.cz]
> > > This patch works on s390, s390x, x86 and ia64 architectures.
> > > It can also be applied against 2.4.16 with a little modification.
> > > 
> > > Down CPU
> > > echo 0 > /proc/sys/kernel/cpu/<id>/online
> > > 
> > > Up CPU
> > > echo 1 > /proc/sys/kernel/cpu/<id>/online
> > 
> > Such patches are neccessary for ACPI S3/S4 sleep support. It 
> > would be nice to
> > apply them soon.
> 
> They are???

If you are going to S4 sleep, you should better make sure no other
processors are changing stuff under your hands. Easiest way to do that
is by putting them offline (I see no other good solutions). For S3
having to save state of one CPU is bad enough, having to save state of
8 would be bad, so putting them offline would be handy, too.
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
