Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVFKTjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVFKTjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVFKTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:36:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261803AbVFKTfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:35:01 -0400
Date: Sat, 11 Jun 2005 15:35:00 -0400
From: Neil Horman <nhorman@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Neil Horman <nhorman@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050611193500.GC1097@devserv.devel.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com> <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 07:07:15PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 10, 2005 at 08:05:48PM -0400, Neil Horman wrote:
> > Hey there!
> > 	I've recently developed this patch in pursuit of an ability to trap
> > proceses making modifcations to monitored directories, and I thought It would be
> > a nice feature to add to the mainline kernel.  It basically adds a flag to the
> > F_NOTIFY fcntl which optionally sends a SIGSTOP to the process making the
> > flagged modifications to the monitored directories, and passes the pid of the
> > stopped process to the monitoring process.  I've tested it, and it works quite
> > well for me.  Looking for comments/approvial/incorporation.
> 
> What stops me from setting a DN_STOPSND on /lib and preventing any new
> tasks from starting up?
> 
Good point.  Would it be sufficient to limit this ability to root owned
processes only?  Does it seem like a beneficial feature otherwise?

Thanks and Regards
Neil

> -- 
> "Next the statesmen will invent cheap lies, putting the blame upon 
> the nation that is attacked, and every man will be glad of those
> conscience-soothing falsities, and will diligently study them, and refuse
> to examine any refutations of them; and thus he will by and by convince 
> himself that the war is just, and will thank God for the better sleep 
> he enjoys after this process of grotesque self-deception." -- Mark Twain

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
