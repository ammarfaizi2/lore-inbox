Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWITR3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWITR3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWITR3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:29:08 -0400
Received: from smtp-out.google.com ([216.239.45.12]:18105 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932097AbWITR3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:29:05 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=LejJKwf6yU0Ytgdjrei8SCVffbLka9xTffL3i0gn8Am2WzZ6RU0731XHPoNbmqD8M
	c5n3wYRzcz9+uhWrg5twA==
Subject: Re: [patch01/05]:Containers(V2): Documentation
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609200940550.30754@schroedinger.engr.sgi.com>
References: <1158718655.29000.47.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200940550.30754@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 10:28:47 -0700
Message-Id: <1158773327.8574.55.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 09:43 -0700, Christoph Lameter wrote:
> On Tue, 19 Sep 2006, Rohit Seth wrote:
> 
> > +Currently we are tracking user memory (both file based
> > +and anonymous).  The memory handler is currently deactivating pages
> > +belonging to a container that has gone over the limit. Even though this
> > +allows containers to go over board their limits but 1- once they are
> > +over the limit then they run in degraded manner and 2- if there is any
> > +memory pressure then the (extra) pages belonging to this container are
> > +the prime candidates for swapping (for example).  The statistics that
> > +are shown in each container directory are the current values of each
> > +resource consumption.
> 
> Containers via cpusets allow a clean implementation of a restricted memory 
> area. The system will swap and generate an OOM message if no memory can be 
> recovered.
> 
> > +4- Add a task to container
> > +	cd /mnt/configfs/cotnainers/test_container
> > +	echo <pid> > addtask
> > +
> > +Now the <pid> and its subsequently forked children will belong to container
> > +test_container.
> > +
> > +5- Remove a task from container
> > +	echo <pid> > rmtask
> 
> Could you make that compatible with the way cpusets do it?
> 
> > +9- Freeing a container
> > +	cd /mnt/configfs/containers/
> > +	rmdir test_container
> 
> Adding and removal is the same way as cpusets.

Most of the syntax of cpuset is in terms of nodes and CPU numbers.  That
is not the case here in containers.

-rohit

