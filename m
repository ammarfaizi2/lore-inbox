Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbUKWJdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbUKWJdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKWJde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:33:34 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:20434 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262393AbUKWJdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:33:32 -0500
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20041123090325.GA22114@infradead.org>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
	 <20041123090325.GA22114@infradead.org>
Date: Tue, 23 Nov 2004 10:33:27 +0100
Message-Id: <1101202407.6210.87.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 10:40:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 10:40:35,
	Serialize complete at 23/11/2004 10:40:35
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 09:03 +0000, Christoph Hellwig wrote:
> On Tue, Nov 23, 2004 at 07:03:17AM +0100, Guillaume Thouvenin wrote:
> > 
> >    For a module, I need to execute a function when a fork occurs. My
> > solution is to add a pointer to a function (called fork_hook) in the
> > do_fork() and if this pointer isn't NULL, I call the function. To update
> > the pointer to the function I export a symbol (called trace_fork) that
> > defines another function with two parameters (the hook and an
> > identifier). This function provides a simple mechanism to manage access
> > to the fork_hook variable.
> > 
> Use SGI's PAGG patches if you want such hooks.  Also this is clearly
> a _GPL export.

PAGG is more intrusive than my patch due to the management of groups of
processes. This hook in the fork allows me to provide a solution to do
per-group accounting with a module. If PAGG is added in the Linux Kernel
Tree it could be the solution, you are right. 

Guillaume 


