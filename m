Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314272AbSD0Pxu>; Sat, 27 Apr 2002 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314273AbSD0Pxt>; Sat, 27 Apr 2002 11:53:49 -0400
Received: from ASYNC2-9.NET.CS.CMU.EDU ([128.2.188.66]:5892 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S314272AbSD0Pxs>; Sat, 27 Apr 2002 11:53:48 -0400
Date: Sat, 27 Apr 2002 11:53:24 -0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020427155323.GA1275@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <20020410221211.GA6076@ravel.coda.cs.cmu.edu> <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk> <5.1.0.14.2.20020412015633.01f1f3c0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020412080524.00ac6220@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 08:57:17AM +0100, Anton Altaparmakov wrote:
> Yet, this really begs the question of defining the concept of a file. I am 
> quite happy with files being the io entity in ntfs. It is just that each 
> file in ntfs can contain loads of different data holding attributes which 
> are all worth placing in address spaces. Granted, a dummy inode could be 
> setup for each of those which just means a lot of wasted ram but ntfs is 
> not that important so I have to take the penalty there. But if I also need 
> unique inode numbers in those dummy inodes then the overhead is becoming 
> very, very high...

You could have all additional IO streams use the same inode number and
use iget4. Several inodes can have the same i_ino and the additional
argument would be a stream identifier that selects the correct 'IO
identity'.

Jan

