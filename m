Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263120AbSJFCNK>; Sat, 5 Oct 2002 22:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbSJFCNF>; Sat, 5 Oct 2002 22:13:05 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:19210 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S263189AbSJFCMc>; Sat, 5 Oct 2002 22:12:32 -0400
Date: Sat, 5 Oct 2002 19:18:02 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006021802.GA31878@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021005235614.GC25827@stud.ntnu.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 01:56:14AM +0200, Thomas Langås wrote:
> Jan Hudec:
> > On the other hand it's a bug if a process stays in D-state for time of
> > order of seconds or more. Unfortunately it's impossible to avoid this
> > in networking filesystems with current state of VFS (in 2.4). Even there
> > though, it's a bug if it's indefinite.
> 
> Well, it's NFS-related (we use autofs to mount our nfs-shares), and the
> processes are staying forever when they have gotten to the D-state.
> 
> > These problems were already discussed on LKML, you might want to search
> > the archive. IIRC this is a known problem of OpenAFS (not in standart
> > kernel). It was reported with various drivers for some 2.4.x kernels
> > too.
> 
> As you see, we've got this problem with NFS as the filesystem, and 
> the processes won't die or return, they just hang there setting
> the load-number up in the roof.

They shouldn't be affecting the load average because they
aren't on the runqueue.

It sounds like you have a problem with your NFS server.  Be
sure you set the automounter's mount options to include 'intr'
That will allow you to interrupt your processes if the server goes
offline.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
