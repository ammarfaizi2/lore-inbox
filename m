Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279649AbRJXXsb>; Wed, 24 Oct 2001 19:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279650AbRJXXsW>; Wed, 24 Oct 2001 19:48:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26103
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279649AbRJXXsJ>; Wed, 24 Oct 2001 19:48:09 -0400
Date: Wed, 24 Oct 2001 16:48:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: Mart?n Marqu?s <martin@bugs.unl.edu.ar>,
        Marc Brekoo <kernel@brekoo.no-ip.com>, linux-kernel@vger.kernel.org
Subject: Re: howto see shmem
Message-ID: <20011024164837.B22668@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Mart?n Marqu?s <martin@bugs.unl.edu.ar>,
	Marc Brekoo <kernel@brekoo.no-ip.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar> <005001c15ce2$1123aec0$0500a8c0@brekoo.noip.com> <20011024232744.F14D62AB49@bugs.unl.edu.ar> <1003966646.3520.110.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1003966646.3520.110.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 07:37:26PM -0400, Robert Love wrote:
> On Wed, 2001-10-24 at 19:27, Mart?n Marqu?s wrote:
> > [...]
> > ------ Shared Memory Segments --------
> > key       shmid     owner     perms     bytes     nattch    status
> > 0x00000000 65536     nobody    600       46084     11        dest
> > [...]
> > I can see 46084 bytes in shared memory used by the apache.
> > Am I wrong?
> 
> Nope.  Applications know how much the are sharing because they can
> easily see what region of memory is shared/mapped into their's.
> 
> The reason the kernel can't figure out the net shared memory is because
> there is no simple way -- it has to add up the shared regions of all
> applications, counting each shared segment only once.  Too much work.
> 

Actually, if it's done in the COW code, you could quite possibly get most of
it right there...

Does anyone know of something that can make use of the shmem accting?
