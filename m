Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288975AbSAIT3N>; Wed, 9 Jan 2002 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSAIT3D>; Wed, 9 Jan 2002 14:29:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:41953 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288971AbSAIT2z>; Wed, 9 Jan 2002 14:28:55 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201091928.g09JSdH23535@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Wed, 9 Jan 2002 11:28:39 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, andrea@suse.de
In-Reply-To: <20020109132148.C12609@redhat.com> from "Benjamin LaHaise" at Jan 09, 2002 12:21:48 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

By any chance do you have a list of drivers that assume this ? 
What does it take to fix them ? 

I think Jens BIO changes for 2.5 will fix this problem. But 
2.4 needs a solution in this area too. This patch showed 
significant improvement for database workloads. 

If it is not reasonable to fix all the brokern drivers,
how about making this configurable (to do variable size IO) ?
Do you favour this solution ?

Regards,
Badari


> 
> On Wed, Jan 09, 2002 at 10:12:11AM -0800, Badari Pulavarty wrote:
> > why ? could you explain ? I am not expecting that user buffer be aligned
> > to PAGE_SIZE.
> 
> Okay, that part I misread from the message, but that leaves the question of 
> "does it work?"  Iirc, Jeff Merkey tested variable sized ios with nwfs, but 
> found that triggered bugs in the low level drivers, some of which assume that 
> all buffer heads within a request have the same block size.  Given that 
> concern, I really don't think this is a safe 2.4 patch.
> 
> 		-ben
> -- 
> Fish.
