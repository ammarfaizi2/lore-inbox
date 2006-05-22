Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWEVRHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWEVRHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWEVRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:07:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750998AbWEVRHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:07:12 -0400
Date: Mon, 22 May 2006 10:06:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, raven@themaw.net
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use
 aio_read/aio_write instead
Message-Id: <20060522100640.0710f7da.akpm@osdl.org>
In-Reply-To: <1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	<1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
	<20060521180037.3c8f2847.akpm@osdl.org>
	<1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Sun, 2006-05-21 at 18:00 -0700, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > This patch removes readv() and writev() methods and replaces
> > >  them with aio_read()/aio_write() methods.
> > 
> > And it breaks autofs4
> > 
> > autofs: pipe file descriptor does not contain proper ops
> > 
> 
> Any easy test case to reproduce the problem ?
> 

Grab an FC5 setup, copy RH's .config into your tree.
