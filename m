Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRDBNBn>; Mon, 2 Apr 2001 09:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDBNBd>; Mon, 2 Apr 2001 09:01:33 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:48220 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129116AbRDBNBV>; Mon, 2 Apr 2001 09:01:21 -0400
Date: Mon, 2 Apr 2001 09:00:25 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pthreads & fork & execve
Message-ID: <20010402090025.X1169@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <01033016225700.00409@dennis> <Pine.LNX.4.21.0104021338320.8447-100000@bellatrix.tat.physik.uni-tuebingen.de> <20010402095425.A15554@tux.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010402095425.A15554@tux.distro.conectiva>; from niemeyer@conectiva.com on Mon, Apr 02, 2001 at 09:54:25AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 09:54:25AM -0300, Gustavo Niemeyer wrote:
> Hi Richard! Hi Dennis!
> 
> > I tracked this down to a corrupt jumptable somewhere in the pthreads
> > part of the libc (didnt have the source handy at that time, though). So
> > I think this is a libc bug (version does not matter) - I even did a
> > followup to a similar bug in the libc gnats database (I think I should
> > have opened a new one, though...). But I failed to construct a "simple"
> > testcase showing the bug (We use rather large amount of threads and
> > in one or two doing popen() calls - or handcrafted fork() && execv(),
> > the SIGSEGV is during fork()).
> 
> We're going trough two similar problems here. One is KDE, and the other
> is Linuxconf. Linuxconf is core dumping on a module when it is linked
> with pthread and dlopen()'ed with RTLD_GLOBAL. We must reduce one of
> them to a testcase.

By any chance, are you dlopening a DSO linked against -lpthread from
program not linked against -lpthread?

	Jakub
