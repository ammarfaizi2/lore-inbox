Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbSJQVWA>; Thu, 17 Oct 2002 17:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSJQVWA>; Thu, 17 Oct 2002 17:22:00 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:22710 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262120AbSJQVV7>;
	Thu, 17 Oct 2002 17:21:59 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Benjamin LaHaise <bcrl@redhat.com>
Date: Thu, 17 Oct 2002 23:27:16 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: statfs64 missing
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, ak@muc.de
X-mailer: Pegasus Mail v3.50
Message-ID: <4E53FFF4EC7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Oct 02 at 15:41, Benjamin LaHaise wrote:
> On Thu, Oct 17, 2002 at 02:01:11AM +0200, Andi Kleen wrote:
> ...
> > So it boils down to if the new fields are important enough to justify
> > the pain they cause on 64bit.
> > 
> > (I ran into a similar issue with my nanosecond stat patchkit - 
> > alpha stat is 64bit clean, but doesn't have the padding for ns fields
> > added used in later ports)
> 
> If any new stat() type syscalls are added, make sure that a length parameter 
> of the structure gets passed in from userland, as that way we will be able 
> to extend the available information without introducing yet another syscall 
> on every arch (this has happened enough times now that we should try to get 
> it right).

And if VFS could get access to dentry which was used for statfs,
I (and ncpfs) will be very happy, as then I can report space available
for user after applying directory restrictions just through normal
statfs call, instead of using own special call.

I understand that then it becomes more inode than superblock operation,
and that it is too late for 2.6...
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
