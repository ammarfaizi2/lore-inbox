Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTCEUWY>; Wed, 5 Mar 2003 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCEUWY>; Wed, 5 Mar 2003 15:22:24 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51702 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261451AbTCEUWW>;
	Wed, 5 Mar 2003 15:22:22 -0500
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: High Mem Options 
In-reply-to: Your message of Wed, 05 Mar 2003 04:26:54 PST.
             <20030305122654.GR1195@holomorphy.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11065.1046896263.1@us.ibm.com>
Date: Wed, 05 Mar 2003 12:31:03 -0800
Message-Id: <E18qfXc-0002sX-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Mar 2003 04:26:54 PST, William Lee Irwin III wrote:
> On Wed, Mar 05, 2003 at 06:28:36AM -0500, Reed, Timothy A wrote:
> > 	Yet another quick question...is there any down side to using the
> > 64GB option over the 4GB option if the machine only has 2GB of RAM onboard??
> > I would think this would be a performance issue?  Does the kernel only use
> > the translation table if it has to access any memory location over 4GB?
> 
> Yes, the additional level of pagetables slows things down quite a bit.

Bill, do you hvae measures for this?  I seem to remember PTX's impact
of PAE36 as being about 3-5% depending on workload.  Janet did one test
sometime back with DB2 that showed a net of no difference on TPC-H (PAE
slows things down, less memory pressure speeds things up) but Badari
just repeated with 2.5.62 or 2.5.63 and saw a larger degradation.

I'm wondering if some hardware is not getting correctly configured at
boot with with respect to MTRR's, perhaps...  I really wouldn't expect
a 10% impact from PAE and I don't have any consistent Linux measurements
to validate or invalidate that much impact.

gerrit
