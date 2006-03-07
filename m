Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWCGBhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWCGBhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCGBhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:37:19 -0500
Received: from sccrmhc11.comcast.net ([204.127.200.81]:13460 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751247AbWCGBhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:37:17 -0500
Subject: Re: Status of AIO
From: Nicholas Miell <nmiell@comcast.net>
To: Dan Aloni <da-x@monatomic.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060307013049.GA19775@localdomain>
References: <20060306062402.GA25284@localdomain>
	 <20060306211854.GM20768@kvack.org>  <20060307013049.GA19775@localdomain>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 17:37:13 -0800
Message-Id: <1141695433.2993.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 03:30 +0200, Dan Aloni wrote:
> On Mon, Mar 06, 2006 at 04:18:54PM -0500, Benjamin LaHaise wrote:
> > On Mon, Mar 06, 2006 at 08:24:03AM +0200, Dan Aloni wrote:
> > > Hello,
> > > 
> > > I'm trying to assert the status of AIO under the current version 
> > > of Linux 2.6. However by searching I wasn't able to find any 
> > > indication about it's current state. Is there anyone using it
> > > under a production environment?
> > 
> > For O_DIRECT aio things are pretty stable (barring a patch to improve -EIO 
> > handling).  The functionality is used by the various databases, so it gets 
> > a fair amount of exercise.
> > 
> > > I'd like to know how complete it is and whether socket AIO is
> > > adaquately supported.
> > 
> > Socket AIO is not supported yet, but it is useful to get user requests to 
> > know there is demand for it.
> 
> Well, I've written a small test app to see if it works with network
> sockets and apparently it did for that small test case (connect() 
> with aio_read(), loop with aio_error(), and aio_return()). I thought 
> perhaps the glibc implementation was running behind the scene, so I've 
> checked to see if it a thread was created in the background and I 
> there wasn't any thread. 

None of the aio_* functions use the kernel's AIO interface. They're
implemented entirely in userspace using a thread pool.

-- 
Nicholas Miell <nmiell@comcast.net>

