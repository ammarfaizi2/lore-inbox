Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJYNen>; Thu, 25 Oct 2001 09:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273918AbRJYNed>; Thu, 25 Oct 2001 09:34:33 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:24480 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S273912AbRJYNeW> convert rfc822-to-8bit; Thu, 25 Oct 2001 09:34:22 -0400
From: Christoph Rohland <cr@sap.com>
To: =?iso-8859-1?q?Mart=EDn_Marqu=E9s?= <martin@bugs.unl.edu.ar>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: howto see shmem
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar>
Organisation: SAP LinuxLab
Date: 25 Oct 2001 15:34:20 +0200
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar>
Message-ID: <m3g087268z.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martín,

On Wed, 24 Oct 2001, Martín Marqués wrote:
> I have found out that /proc/meminfo doesn't have (at least that's my
> first thought) info about shared memory (it shows 0, even in heavy
> duty servers). 

/proc/meminfo did show the number of shared pages in the whole system
independent of SYSV shared mem.

In the -ac series it shows all shared anonymous pages
(i.e. tmpfs, shared mmap and SYSV shm pages)

> ipcs also shows nothing, so how can I see the amount
> of shared memory being used?  

linux:~ # ipcs -mu

------ Shared Memory Status --------
segments allocated 3
pages allocated 256
pages resident  12
pages swapped   87
Swap performance: 0 attempts     0 successes

It shows it.

> Th mounted /dev/shmem device also shows 0 kb used (just in case).

That would only show the posix shared memory segments in this
instance.

Greetings
		Christoph


