Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUG0Bai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUG0Bai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUG0Bah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:30:37 -0400
Received: from web50901.mail.yahoo.com ([206.190.38.121]:35943 "HELO
	web50901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266212AbUG0B2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:28:07 -0400
Message-ID: <20040727012807.96145.qmail@web50901.mail.yahoo.com>
Date: Mon, 26 Jul 2004 18:28:07 -0700 (PDT)
From: sankarshana rao <san_wipro@yahoo.com>
Subject: Re: Inode question
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1090506209.8842.20.camel@pmarqueslinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the inputs..
I am trying this thing on Mips processor and creating
500 folders itself takes about 1.6 seconds. That's why
I was wondering if using inodes would make it any
faster..
pls guide...



--- Paulo Marques <pmarques@grupopie.com> wrote:
> On Wed, 2004-07-21 at 23:57, sankarshana rao wrote:
> > Guys,
> > Thx for the inputs...I got it with path_lookup....
> > 
> > Can I pass the inode pointer back to the user
> space???
> 
> To get an inode number from user space you can
> simply use the "stat" or
> "fstat" functions. You don't need to create your own
> module.
> 
> > I have a scenario in which I have to create
> multiple
> > folders on the harddisk. The number of folders can
> be
> > in hundreds. Instead of parsing the path name
> > everytime I need to create a folder (that's what
> > sys_mkdir does??? ), I was thinking if I have the
> > inode* of the parent folder, I can avoid this
> parsing
> > and directly create a subfolder under the parent
> > folder...
> 
> Is this really a problem? The dentry cache should
> make this quite fast,
> leaving the bottleneck to the actual write on disk
> of the result.
> 
> I tried a small program (if it can be called a
> program) to create a
> thousand directories and it takes less than 100 ms
> on my machine.
> 
> Best regards,
> 
> -- 
> Paulo Marques - www.grupopie.com
> "In a world without walls and fences who needs
> windows and gates?"
> 
> 



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
