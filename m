Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264498AbRFLOSN>; Tue, 12 Jun 2001 10:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbRFLOSD>; Tue, 12 Jun 2001 10:18:03 -0400
Received: from stanis.onastick.net ([207.96.1.49]:47113 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S262575AbRFLORq>; Tue, 12 Jun 2001 10:17:46 -0400
Date: Tue, 12 Jun 2001 10:17:22 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org, rsync-bugs@samba.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <20010612101722.B23934@sigkill.net>
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk> <20010612160931.E27591@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010612160931.E27591@jaquet.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Rasmus Andersen did have cause to say:

> On Tue, Jun 12, 2001 at 02:59:12PM +0100, Jeremy Sanders wrote:
> > I'm getting numerous rsync (v2.4.6) problems under Linux 2.4.2 (RedHat
> > 7.1) or stock 2.4.4 on several machines. rsync often hangs copying files
> 
> I could swear that during early 240-testX this was not a problem,
> but when I finally made a report about it and tried to go back
> through earlier kernels, I could not reproduce. Also, this is
> not reproducable under 2.2.X (for me, at least).

Just a 'me too!' but I'm inclined to think 'rsync bug' because it happens
on Redhat+2.4.x, Debian+2.4.x and Debian+2.2.18 - we finally gave up on
rsync for big-stuff-site-to-site and went back to scp. (It was -way-
faster to scp 4 gigs than to rsync the 50 megs or so of changes. It would
run, then freeze (usually at different places - if it froze twice in the
same place we'd just scp the file manually), so we'd wander past and
kill/restart it, repeat. Fastest total was 4 days, where the two of us
checked it every couple of hours over the weekend.)

We're (trying to) using it in real-life-big-data environment, so if you
need debuggers/more info/etc let me know. 

(I'm on LKML but not rsync-bugs, so cc me from that side.. thanks!)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
