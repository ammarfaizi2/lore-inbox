Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276709AbRJBVeN>; Tue, 2 Oct 2001 17:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRJBVeE>; Tue, 2 Oct 2001 17:34:04 -0400
Received: from [194.213.32.137] ([194.213.32.137]:10500 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276707AbRJBVdu>;
	Tue, 2 Oct 2001 17:33:50 -0400
Date: Mon, 1 Oct 2001 09:28:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        padraig@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: CPU frequency shifting "problems"
Message-ID: <20011001092850.A35@toy.ucw.cz>
In-Reply-To: <8FB7D6BCE8A2D511B88C00508B68C2081971D8@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8FB7D6BCE8A2D511B88C00508B68C2081971D8@orsmsx102.jf.intel.com>; from andrew.grover@intel.com on Thu, Sep 27, 2001 at 06:24:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > For example, the Intel "SpeedStep" CPU's are completely broken under
> > > Linux, and real-time will advance at different speeds in DC 
> > and AC modes,
> > > because Intel actually changes the frequency of the TSC 
> > _and_ they don't
> > > document how to figure out that it changed.
> > 
> > The change is APM or ACPI initiated. Intel won't tell anyone anything
> > useful but Microsoft have published some of the required 
> > intel confidential
> > information which helps a bit
> 
> APM is a lost cause, but the correct solution for ACPI systems is to use the
> PM timer. This totally obviates the need to really care about the CPU's
> effective frequency at all. Even if you knew all the details of SpeedStep
> (and I've seen the same MS doc you have Alan and was surprised at its
> detail) you'd still be hosed if the CPU throttles...you'd be hosed in a
> *good* way because at least any delays would be longer (not shorter) than
> expected but your times would be off nonetheless.

And if it is thermal-throttledduring bogomips calibration...? [Well possible,
acpi is not active that early]

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

