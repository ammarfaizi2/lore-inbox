Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVBKMhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVBKMhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 07:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVBKMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 07:37:10 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42455 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262128AbVBKMhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 07:37:03 -0500
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm2] Relay Fork Module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>,
       Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050211005446.081aa075.akpm@osdl.org>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
	 <20050207154623.33333cda.akpm@osdl.org>
	 <1108109504.30559.43.camel@frecb000711.frec.bull.fr>
	 <20050211005446.081aa075.akpm@osdl.org>
Date: Fri, 11 Feb 2005 13:32:44 +0100
Message-Id: <1108125164.30559.51.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/02/2005 13:41:25,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/02/2005 13:45:44,
	Serialize complete at 11/02/2005 13:45:44
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 00:54 -0800, Andrew Morton wrote:
> >   I tested this patch on a 2.6.11-rc3-mm2 kernel and there is a little
> > overhead when I compile a Linux kernel:
> > 
> >    #time sh -c 'make O=/home/guill/build/k2610 bzImage && 
> >    make O=/home/guill/build/k2610 modules'
> > 
> >    with a vanilla kernel: real    8m10.797s
> > 	                  user    7m29.652s
> > 			  sys     0m49.275s
> >    
> >    with the forkuevent patch : real    8m16.189s
> >                     	       user    7m28.841s
> > 		    	       sys     0m49.155s
> 
> Was that when some process was monitoring the netlink socket?

  The test was done without monitoring. I ran another one with
monitoring and the result is:

	real    8m12.747s
	user    7m30.761s
        sys     0.51.414s

  As I only tested each case only once, I'm going to run the same test
five times to have a more accurate results.

  Thank you very much for your comments, I'm carefully looking all of
them. I will send comments next week.

Regards,
Guillaume

