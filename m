Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270727AbRHPEAN>; Thu, 16 Aug 2001 00:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270728AbRHPEAD>; Thu, 16 Aug 2001 00:00:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:5792 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270727AbRHPEAA>;
	Thu, 16 Aug 2001 00:00:00 -0400
Date: Thu, 16 Aug 2001 05:59:19 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: daddr_t is inconsistent and barely used
Message-ID: <20010816055919.A30279@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20010816052119.A28800@caldera.de> <200108160352.f7G3qbw236026@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108160352.f7G3qbw236026@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, Aug 15, 2001 at 11:52:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 11:52:37PM -0400, Albert D. Cahalan wrote:
> Christoph Hellwig writes:
> >>> In article <9980.997929632@kao2.melbourne.sgi.com> you wrote:
> 
> >>>> The use of daddr_t in freevxfs may give different in core
> >>>> and disk layouts on different machines.  Is that intended?.
> ...
> > vx_daddr_t is for disk structures, daddr_t for core.
> 
> This is asking for trouble. The disk structures aren't about
> to change. See include/linux/ext2_fs.h for a safe way to do
> the on-disk structure. For the in-core stuff, "unsigned long"
> is a perfectly fine data type -- and yes I know it gets wider
> with a 64-bit system.

Please take a look how vx_daddr_t is defined - just because I prefer
descriptive names I am not stupid.

	Christoph

> Don't forget to add explicit padding as needed to give natural alignment.

Thanks for you help, I have never worked with structure layouts before..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
