Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbWADSqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWADSqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWADSqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:46:54 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:64715 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S965264AbWADSqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:46:53 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [OT] ALSA userspace API complexity
Date: Wed, 4 Jan 2006 18:46:54 +0000
User-Agent: KMail/1.9
Cc: patrizio.bassi@gmail.com, Jaroslav Kysela <perex@suse.cz>,
       "Kernel, " <linux-kernel@vger.kernel.org>
References: <4uzow-1g5-13@gated-at.bofh.it> <43BBB7DC.2060303@gmail.com> <20060104190705.36488cb5@mango.fruits.de>
In-Reply-To: <20060104190705.36488cb5@mango.fruits.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041846.54689.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 18:07, Florian Schmidt wrote:
> On Wed, 04 Jan 2006 12:56:12 +0100
>
> Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> > that's a big problem. Needs a radical solution. Considering aoss works
> > in 50% of cases i suggest aoss improvement and not OSS keeping in kernel.
>
> aoss works _much_ less often than the OSS emulation kernel modules. I'd
> rather see (if not just for ease of setup), sw mixing in the OSS
> emulation kernel modules. aoss should still continue to exist as it has
> some advanced functionality like being able to use any alsa defined pcm
> device, but for the vast majority of cases it would be the best if the
> OSS emulation kernel module simply finally provided sw mixing.
>
> It might also be worth taking a look at FUSE and stuff like oss2jack
> instead, as it would be (imho) the cleaner approach for getting OSS
> emulation to userspace as opposed to aoss (device file interface vs.
> ugly LD_PRELOAD hack (which has its share of problems. Especially with
> apps/libs that resolved the linux system call symbols at compile time -
> this is where aoss/LD_PRELOAD won't work, but a FUSE based approach
> would)).
>
> Actually i suppose a FUSE based oss2alsa would probably make the old OSS
> emulation modules unnecessary if implemented right :) As the relevant
> code then lives in userspace it can make trivial use of stuff like ALSA
> sw mixing and all other ALSA userspace goodies (which aoss can, too, but
> at the cost of being an ugly LD_PRELOAD hack).

Not to disrespect Miklos's work, but relying on FUSE for such a fundamental 
problem is probably not a good idea. Most people probably do not compile FUSE 
into their kernel.

I do agree with other posters here that OSS compatibility a) needs to be 
improved and b) should not be limited to the features of the soundcard (i.e. 
it must software mix). As Andi has pointed out, wholly removing OSS is not in 
the spirit of Linux and will not happen for many years.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
