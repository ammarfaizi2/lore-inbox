Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279646AbRJXXhV>; Wed, 24 Oct 2001 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279645AbRJXXhL>; Wed, 24 Oct 2001 19:37:11 -0400
Received: from zero.tech9.net ([209.61.188.187]:54280 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279649AbRJXXg6> convert rfc822-to-8bit;
	Wed, 24 Oct 2001 19:36:58 -0400
Subject: Re: howto see shmem
From: Robert Love <rml@tech9.net>
To: =?ISO-8859-1?Q?Mart=EDn_Marqu=E9s?= <martin@bugs.unl.edu.ar>
Cc: Marc Brekoo <kernel@brekoo.no-ip.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011024232744.F14D62AB49@bugs.unl.edu.ar>
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar>
	<005001c15ce2$1123aec0$0500a8c0@brekoo.noip.com> 
	<20011024232744.F14D62AB49@bugs.unl.edu.ar>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16 (Preview Release)
Date: 24 Oct 2001 19:37:26 -0400
Message-Id: <1003966646.3520.110.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-24 at 19:27, Martín Marqués wrote:
> [...]
> ------ Shared Memory Segments --------
> key       shmid     owner     perms     bytes     nattch    status
> 0x00000000 65536     nobody    600       46084     11        dest
> [...]
> I can see 46084 bytes in shared memory used by the apache.
> Am I wrong?

Nope.  Applications know how much the are sharing because they can
easily see what region of memory is shared/mapped into their's.

The reason the kernel can't figure out the net shared memory is because
there is no simple way -- it has to add up the shared regions of all
applications, counting each shared segment only once.  Too much work.

	Robert Love

