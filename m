Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKZUuM>; Tue, 26 Nov 2002 15:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSKZUuL>; Tue, 26 Nov 2002 15:50:11 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:478 "EHLO lmail.actcom.co.il")
	by vger.kernel.org with ESMTP id <S261173AbSKZUuL>;
	Tue, 26 Nov 2002 15:50:11 -0500
Date: Tue, 26 Nov 2002 23:03:15 +0200
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANN: syscalltrack 0.80 "Tanned Otter" released
Message-ID: <20021126210314.GZ6536@alhambra>
References: <20021123201015.GD6536@alhambra> <20021126181947.GB1376@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126181947.GB1376@zaurus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 07:19:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> > criteria. syscalltrack can operate either in "tweezers mode", where
> > only very specific operations are tracked, such as "only track and log
> > attempts to delete /etc/passwd", or in strace(1) compatible mode,
> > where all of the supported system calls are traced. syscalltrack can
> > do things that are impossible to do with the ptrace mechanism, because
> > its core operates in kernel space. 
> 
> What stuff can you do that ptrace can't?

Everything that stems from being 1) kernel based and 2) system
wide. ptrace is inherently process based - "show me what this process
did". syscalltrack is system wide - "show me *which* process did this
or that."[1]

syscalltrack also has better filtering than strace, and supports
actions - fail the system call if it passed that filter, suspend the
process if it passed that filter, etc. 

Basically, there are things which strace is good for, and there are
things subterfuge is good for, and there are things syscalltrack is
good for. Use the right tool for the job. You can see more about
syscalltrack's capabilities on the website. 

[1] You can probably emulate syscalltrack's system wide behaviour by
ptracing init and all of its forked children, but your system will
slow to a crawl. With syscalltrack, you'll barely feel anything. 
-- 
Muli Ben-Yehuda				    http://www.mulix.org/
mulix@mulix.org:~$ sctrace strace /bin/foo  http://syscalltrack.sf.net/
Quis custodes ipsos custodiet? 
