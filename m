Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbTC1LeD>; Fri, 28 Mar 2003 06:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbTC1LeD>; Fri, 28 Mar 2003 06:34:03 -0500
Received: from angband.namesys.com ([212.16.7.85]:6806 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262959AbTC1LeC>; Fri, 28 Mar 2003 06:34:02 -0500
Date: Fri, 28 Mar 2003 14:45:12 +0300
From: Oleg Drokin <green@namesys.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       Bill Huey <billh@gnuppy.monkey.org>
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
Message-ID: <20030328144512.A13144@namesys.com>
References: <20030327092207.GA1248@gnuppy.monkey.org> <20030327200702.A30403@namesys.com> <200303281012.26031.schlicht@uni-mannheim.de> <200303281157.51743.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303281157.51743.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 28, 2003 at 11:57:42AM +0100, Thomas Schlichter wrote:
> On Mar 27, 2003 18:07, Oleg Drokin wrote:
> > sb->s_export_op->find_exported_dentry is NULL
> > in reiserfs_decode_fh, well. In fact we never set this field at all.
> > What is supposed to be there, anyway?
> > I guess following patch should fix the problem.
> Yes, it did fix the problem, but now I was not allowed anymore to compile NFS 
> as a module as I need reiserfs to be in the kernel... :-(

Well, in fact this not real fix as I see it, it is just a cover for different bug somewhere else.

> > In fact I guess somebody should put find_exported_dentry() declaration to
> > include/linux/fs.h or something like that.
> > Also absolutely the same problem must exist if you try to export fat 
> filesystem.
> That is true, too. I saw the Oops with a VFAT partition, too
> I just wonder why the code in fs/nfsd/export.c lines 684-687 does not work. 

Well, I run the thing in the debugger with current bk snapshot and everything worked.

> This code should set the find_exported_dentry field correctly. But I do not 
> know when this function (exp_export()) is called...

it is called when you mount remote fs, as my debugging session shows.

So I guess problem was already fixed somewhere else.

Bye,
    Oleg
