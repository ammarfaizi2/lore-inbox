Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJWXUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTJWXUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:20:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49620 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261869AbTJWXUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:20:09 -0400
Date: Fri, 24 Oct 2003 01:20:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testing on2.6.0-test7-mm1)
Message-ID: <20031023232006.GH21490@fs.tum.de>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net> <20031020142727.GA4068@in.ibm.com> <1066693673.22983.10.camel@ibm-c.pdx.osdl.net> <20031021121113.GA4282@in.ibm.com> <1066869631.1963.46.camel@ibm-c.pdx.osdl.net> <20031023104923.GA11543@in.ibm.com> <20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023155937.41b0eeda.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 03:59:37PM -0700, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > It turns out that backing out gcc-Os.patch (on RH 9) or switching 
> > to a system with an older compiler version made those errors go away.
> 
> Ho hum, so we have our answer.
> 
> Adrian, how do you feel about slotting this under CONFIG_EMBEDDED?

That was in the first version of the patch, but Christoph Hellwig asked 
to drop the EMBEDDED.

The version I sent to you contained a dependency on EXPERIMENTAL, to 
indicate that -Os is less tested, and the help text says
  If unsure, say N.

IMHO this should be enough, so that only people who know what they are 
doing use this option.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

