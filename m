Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRAITjr>; Tue, 9 Jan 2001 14:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131707AbRAITjh>; Tue, 9 Jan 2001 14:39:37 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:6668
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S131193AbRAITjW>; Tue, 9 Jan 2001 14:39:22 -0500
Date: Tue, 9 Jan 2001 11:34:47 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Mihai Moise <mcartoaj@mat.ulaval.ca>
Cc: Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org
Subject: Re: adding a system call
Message-ID: <20010109113447.B6858@skull.piratehaven.org>
Mail-Followup-To: Brian Pomerantz <bapper@piratehaven.org>,
	Mihai Moise <mcartoaj@mat.ulaval.ca>,
	Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200101091441.JAA12925@taylor.mat> <m3snmsbkmx.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3snmsbkmx.fsf@belphigor.mcnaught.org>; from doug@wireboard.com on Tue, Jan 09, 2001 at 02:17:26PM -0500
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This can all be done with a device file and a corresponding module to
handle the mmap and any ioctl()'s you may want to support.  No need to
add another system call.


BAPper

On Tue, Jan 09, 2001 at 02:17:26PM -0500, Doug McNaught wrote:
> Mihai Moise <mcartoaj@mat.ulaval.ca> writes:
> 
> > My system call idea is to allow a superuser process to request a mmap on
> > behalf of an user process. To see how this would be useful, let us consider
> > svgalib.
> 
> [...]
> 
> > With my new system call, a superuser process can set the graphics mode in a
> > safe manner and then ask for an mmap of the video array into the application
> > data segment.
> 
> Ummm, couldn't the the root process open the video device, then pass
> the file descriptor (via AF_UNIX socket) to the user process?  The
> user process would then call mmap() on the open file descriptor. 
> 
> I'm not *completely* sure this would work, but it would avoid creating 
> a new system call if so.
> 
> -Doug
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
