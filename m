Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWIOSTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWIOSTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIOSTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:19:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41092 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932144AbWIOSTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:19:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=e/cuR4iwIMVa4d0yVRLYCEruNvxHNh8on0ExHEEi9AlQKktbebmEFZx0TrD8VDcg/
	Vvix/UCY2/KIxrK7f1QCQ==
Subject: Re: [Patch 01/05]- Containers: Documentation on using containers
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060915174412.GB5285@atjola.homenet>
References: <1158284314.5408.146.camel@galaxy.corp.google.com>
	 <200609150815.19917.eike-kernel@sf-tec.de>
	 <1158338725.12311.25.camel@galaxy.corp.google.com>
	 <20060915174412.GB5285@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Organization: Google Inc
Date: Fri, 15 Sep 2006 11:19:14 -0700
Message-Id: <1158344354.12311.71.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 19:44 +0200, Björn Steinbrink wrote:
> On 2006.09.15 09:45:25 -0700, Rohit Seth wrote:
> > On Fri, 2006-09-15 at 08:15 +0200, Rolf Eike Beer wrote:
> > > Rohit Seth wrote:
> > > > This patch contains the Documentation for using containers.
> > > 
> > > > +5- Remove a task from container
> > > > +	echo <pid> rmtask
> > > 
> > > echo <pid> > rmtask?
> > > 
> > 
> > rmtask is an attribute defined in test_container directory.  So, first
> > you have to cd into container directory
> > (cd /mnt/configfs/containers/test_container and then execute this
> > command)
> 
> The > is missing in the patch though, guess that's what Rolf wanted to
> point out ;)
> 
Aha. Will fix it.

> > 
> > > Please also give a short description what containers are for. From what I read 
> > > here I can only guess it's about gettings some statistics about a group of 
> > > tasks.
> > 
> > Containers allow different workloads to be run on the same platform with
> > limits defined on per container basis.  This basically allows a single
> > platform to be (soft) partitioned among different workloads (each of
> > which could be running many tasks).  The limits could be amount of
> > memory, number of tasks among other features.  These two features are
> > already implemented in the patch set that I posted.  But it is possible
> > to add other controllers like CPU that allows only finite amount of time
> > to the processes belonging to a container.
> > 
> > Currently this patch set is only tracking user memory (both file based
> > and anonymous).  The memory handler is currently deactivating pages
> > belonging to a container that has gone over the limit. Even though this
> > allows containers to go over board their limits but 1- once they are
> > over the limit then they run in degraded manner and 2- if there is any
> > memory pressure then the (extra) pages belonging to this container are
> > the prime candidates for swapping (for example).  The statistics that
> > are shown in each container directory are the current values of each
> > resource consumption.
> > 
> > Please let me know if you need any more specific information about the
> > patch set.
> 
> A general description for the containers needs to go into Documentation/
> along with the usage example, so that potential users know what to do
> with it. The above seems fine, just remove the "this patch" references.
> 

Okay.

Thanks,
-rohit

