Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSDYAmK>; Wed, 24 Apr 2002 20:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312853AbSDYAmJ>; Wed, 24 Apr 2002 20:42:09 -0400
Received: from 12-225-96-71.client.attbi.com ([12.225.96.71]:56193 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S312790AbSDYAmJ>;
	Wed, 24 Apr 2002 20:42:09 -0400
Date: Wed, 24 Apr 2002 17:42:31 -0700
From: Jerry Cooperstein <coop@axian.com>
To: il boba <il_boba@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: what`s wrong?
Message-ID: <20020424174231.A19184@p3.attbi.com>
In-Reply-To: <F218eE3VsX7PVTdAMDm0000842f@hotmail.com> <20020424164056.GA15812@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 10:40:56AM -0600, Andreas Dilger wrote:
> On Apr 24, 2002  18:06 +0200, il boba wrote:
> > Is there anybody that can help me understand what`s wrong with this code?
......

Even with all this he's going to have trouble since his buffer is in
kernel space and the read is going to expect it to be in user-context...

Reading and writing files from within the kernel is almost never a good
idea and has been made difficult by design.  He should look at what
he is trying to do and perhaps look for another interface, such as
use of ioctls, proc, seq_file, etc..  He probably doesn't need to
do this I/O from within the kernel and should rethink it.

 Jerry Cooperstein  <coop@axian.com>
 Senior Consultant
 Axian, Inc.   <info@axian.com>
 4800 SW Griffith Dr., Ste. 202, Beaverton, OR  97005 USA
 http://www.axian.com/               Software Consulting and Training

