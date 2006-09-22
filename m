Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWIVLB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWIVLB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWIVLB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:01:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932191AbWIVLB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:01:58 -0400
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060916133947.GA1498@infradead.org>
References: <1157031183.3384.793.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
	 <20060916133947.GA1498@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 22 Sep 2006 12:06:53 +0100
Message-Id: <1158923213.11901.374.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-09-16 at 14:39 +0100, Christoph Hellwig wrote:
>
> > >+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
> > >+{
> > >+	int error;
> > >+
> > >+	if (strcmp(current->comm, "nfsd") != 0)
> > 
> > Is not there a better way to do this? Note that there is also a "nfsd4" process
> 
> This is in fact not allowed at at all.  Please fix you readdir code not to
> need special cases for nfsd.
> 

This has now been done in the git tree, and I believe that the resulting
lock ordering will be deadlock free,

Steve.


