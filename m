Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263025AbSJFAam>; Sat, 5 Oct 2002 20:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbSJFAam>; Sat, 5 Oct 2002 20:30:42 -0400
Received: from due.stud.ntnu.no ([129.241.56.71]:16106 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S263025AbSJFAak>;
	Sat, 5 Oct 2002 20:30:40 -0400
Date: Sun, 6 Oct 2002 01:56:14 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021005235614.GC25827@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005182740.GC16200@vagabond>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec:
> On the other hand it's a bug if a process stays in D-state for time of
> order of seconds or more. Unfortunately it's impossible to avoid this
> in networking filesystems with current state of VFS (in 2.4). Even there
> though, it's a bug if it's indefinite.

Well, it's NFS-related (we use autofs to mount our nfs-shares), and the
processes are staying forever when they have gotten to the D-state.

> These problems were already discussed on LKML, you might want to search
> the archive. IIRC this is a known problem of OpenAFS (not in standart
> kernel). It was reported with various drivers for some 2.4.x kernels
> too.

As you see, we've got this problem with NFS as the filesystem, and 
the processes won't die or return, they just hang there setting
the load-number up in the roof.

-- 
Thomas
