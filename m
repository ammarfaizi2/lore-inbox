Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130580AbRCEBXw>; Sun, 4 Mar 2001 20:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130582AbRCEBXm>; Sun, 4 Mar 2001 20:23:42 -0500
Received: from SMTP-OUT003.ONEMAIN.COM ([63.208.208.73]:9572 "HELO
	smtp04.mail.onemain.com") by vger.kernel.org with SMTP
	id <S130580AbRCEBXa>; Sun, 4 Mar 2001 20:23:30 -0500
Message-ID: <3AA2DD8C.E4C5628C@mcn.net>
Date: Sun, 04 Mar 2001 17:27:56 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS-kernel 2.4.3-pre1
In-Reply-To: <Pine.GSO.4.21.0103030140070.17703-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 2 Mar 2001, TimO wrote:
> 
> > eax: 00000000  ebx: 00000000  ecx: 00000000  edx: 00000000
> [snip]
> > >>EIP; c0142a52 <get_new_inode+b2/160>   <=====
> > Trace; c0142ca6 <iget4+b6/d0>
> > Trace; c0145f01 <proc_get_inode+41/120>
> > Trace; c014601a <proc_read_super+3a/b0>
> > Trace; c01349a4 <read_super+104/180>
> > Trace; c0134f7a <kern_mount+2a/80>
> > Trace; c0107007 <init+7/110>
> > Trace; c01074b8 <kernel_thread+28/40>
> > Code;  c0142a52 <get_new_inode+b2/160>
> > 00000000 <_EIP>:
> > Code;  c0142a52 <get_new_inode+b2/160>   <=====
> [snip]
> 
> Lovely. sb->s_op == NULL in iget(). The thing being, proc_read_super()
> explicitly sets ->s_op to non-NULL. Oh, and that area hadn't changed since
> 2.4.2, so I'd rather suspect the b0rken build. Can you reproduce it?
> 
>                                                         Cheers,
>                                                                 Al

Not anymore; rm -rf seems to have fixed it (make mrproper didn't). 
Guess
I should have tried that before posting.  Don't know how it got screwed
up; only 2 patches applied to this tree.

   Thanks,

===============
-- Tim
