Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRC0Ico>; Tue, 27 Mar 2001 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130793AbRC0IcZ>; Tue, 27 Mar 2001 03:32:25 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:2573 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S130900AbRC0IcT>; Tue, 27 Mar 2001 03:32:19 -0500
Date: Tue, 27 Mar 2001 09:31:34 +0100
From: Roger Gammans <roger@computer-surgery.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010327093134.A9031@knuth.computer-surgery.co.uk>
In-Reply-To: <Pine.LNX.4.30.0103231854470.13864-100000@fs131-224.f-secure.com> <Pine.LNX.4.21.0103240252080.1863-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0103240252080.1863-100000@imladris.rielhome.conectiva>; from Rik van Riel on Sat, Mar 24, 2001 at 02:54:55AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2001 at 02:54:55AM -0300, Rik van Riel wrote:
> On Fri, 23 Mar 2001, Szabolcs Szakacsits wrote:
> >  - trying to kill a task that is permanently in TASK_UNINTERRUPTIBLE
> >    will probably deadlock the machine [or the random OOM killer will
> >    kill the box].
> 
> This could indeed be a problem, though I cannot really see any
> case where a task would be in TASK_UNINTERRUPTIBLE permanently.

I've seen this with 'mt rewind' jamming on ide-tape. I'm
not sure of the exact pathology , but ISTR that it
was related issuing that command while the hardware was busy.

In any case the point is that a badly written driver or faulty
h/w even in a subsiduary system can cause this.

In an ideal world of course these wouldn't happen, but OTOH
is this an issue in failing a box which is going to fail
anyway if we don't kill the process. If we could ensure
a graceful failure so much the better.

TTFN
-- 
Roger
     Think of the mess on the carpet. Sensible people do all their
     demon-summoning in the garage, which you can just hose down afterwards.
        --     damerell@chiark.greenend.org.uk
	
