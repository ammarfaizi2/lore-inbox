Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbTCZVCy>; Wed, 26 Mar 2003 16:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTCZVCy>; Wed, 26 Mar 2003 16:02:54 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:10951 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262482AbTCZVCx>; Wed, 26 Mar 2003 16:02:53 -0500
Date: Wed, 26 Mar 2003 13:12:51 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Erik Hensema <erik@hensema.net>, linux-kernel@vger.kernel.org
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Message-ID: <20030326211251.GR19670@ca-server1.us.oracle.com>
References: <20030326013839.0c470ebb.akpm@digeo.com> <slrnb8373s.19a.usenet@bender.home.hensema.net> <20030326134834.GA11173@win.tue.nl> <slrnb83ehl.196.usenet@bender.home.hensema.net> <20030326160350.GA11190@win.tue.nl> <20030326184723.GM19670@ca-server1.us.oracle.com> <20030326205228.GA11217@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326205228.GA11217@win.tue.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:52:28PM +0100, Andries Brouwer wrote:
> > We also should iron out our representations.  eg, hpa's
> > recommendation for 64bits, or the 12/20 split for 32bit, or etc.
> 
> There is no hurry. These changes are just editing a few lines
> in kdev_t.h. I tend to prefer 64 bits, like hpa.
> Maybe I should send another patch tonight, just for playing.

	Please, I'd like that.  It does actually matter, because glibc
and mknod (to name a couple) have to pass a proper dev_t for the new
format (glibc actually does an explicit conversion to 8:8 in
sysdeps/sysv/linux/xmkmod.c, which we need to fix to the proper
mapping).
	Stuff like that.

Joel


-- 

"This is the end, beautiful friend.
 This is the end, my only friend the end
 Of our elaborate plans, the end
 Of everything that stands, the end
 No safety or surprise, the end
 I'll never look into your eyes again."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
