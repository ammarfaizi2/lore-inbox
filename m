Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290793AbSARTnH>; Fri, 18 Jan 2002 14:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSARTm4>; Fri, 18 Jan 2002 14:42:56 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:35335 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290791AbSARTmr>;
	Fri, 18 Jan 2002 14:42:47 -0500
Date: Fri, 18 Jan 2002 11:38:46 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020118193846.GE13310@kroah.com>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <20020116195105.C18039@devcon.net> <20020116230620.GE3410@kroah.com> <20020117102650.A1742@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020117102650.A1742@devcon.net>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 21 Dec 2001 17:17:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 10:26:51AM +0100, Andreas Ferber wrote:
> 
> My concern was conceptual: accessfs is just another mechanism for
> access control to various ressources. As I understand it, LSM is
> intended to move /all/ access control logic into separate modules with
> a uniform interface to the kernel, so that you can choose whatever
> access control mechanism you want (or even rip out all access control,
> as for example some embedded applications don't need it). Clearly it's
> a long way until LSM actually gets to this point, but nevertheless
> it's the overall goal of the whole effort IMHO.

The LSM patch's goal is to only _allow_ you do add access control
mechanisms to the kernel easily.

This accessfs patch doesn't collide with that goal at all.  If it gets
accepted into the kernel, people who write LSM based access control
modules need to remember to medaite access to the accessfs if they want
to.  Since the LSM hooks are much lower in the vfs than accessfs, it is
a simple thing to add this kind of access mediation.

Hope this helps clear it up a bit.

thanks,

greg k-h
