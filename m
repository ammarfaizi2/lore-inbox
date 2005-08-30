Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbVH3XaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVH3XaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVH3XaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:30:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751409AbVH3XaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:30:24 -0400
Date: Tue, 30 Aug 2005 16:28:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: phillips@istop.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-Id: <20050830162846.5f6d0a53.akpm@osdl.org>
In-Reply-To: <20050830231307.GE22068@insight.us.oracle.com>
References: <200508310854.40482.phillips@istop.com>
	<20050830231307.GE22068@insight.us.oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Wed, Aug 31, 2005 at 08:54:39AM +1000, Daniel Phillips wrote:
> > But it would be stupid to forbid users from creating directories in sysfs or 
> > to forbid kernel modules from directly tweaking a configfs namespace.  Why 
> > should the kernel not be able to add objects to a directory a user created?  
> > It should be up to the module author to decide these things.
> 
> 	This is precisely why configfs is separate from sysfs.  If both
> user and kernel can create objects, the lifetime of the object and its
> filesystem representation is very complex.  Sysfs already has problems
> with people getting this wrong.  configfs does not.
> 	The fact that sysfs and configfs have similar backing stores
> does not make them the same thing.
> 

Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
way of providing the slightly different semantics from the same codebase?
