Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWIORoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWIORoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWIORoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:44:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:20138 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750848AbWIORoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:44:16 -0400
X-Authenticated: #5039886
Date: Fri, 15 Sep 2006 19:44:12 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Rohit Seth <rohitseth@google.com>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 01/05]- Containers: Documentation on using containers
Message-ID: <20060915174412.GB5285@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Rohit Seth <rohitseth@google.com>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Andrew Morton <akpm@osdl.org>, devel@openvz.org,
	CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1158284314.5408.146.camel@galaxy.corp.google.com> <200609150815.19917.eike-kernel@sf-tec.de> <1158338725.12311.25.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1158338725.12311.25.camel@galaxy.corp.google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.15 09:45:25 -0700, Rohit Seth wrote:
> On Fri, 2006-09-15 at 08:15 +0200, Rolf Eike Beer wrote:
> > Rohit Seth wrote:
> > > This patch contains the Documentation for using containers.
> > 
> > > +5- Remove a task from container
> > > +	echo <pid> rmtask
> > 
> > echo <pid> > rmtask?
> > 
> 
> rmtask is an attribute defined in test_container directory.  So, first
> you have to cd into container directory
> (cd /mnt/configfs/containers/test_container and then execute this
> command)

The > is missing in the patch though, guess that's what Rolf wanted to
point out ;)

> 
> > Please also give a short description what containers are for. From what I read 
> > here I can only guess it's about gettings some statistics about a group of 
> > tasks.
> 
> Containers allow different workloads to be run on the same platform with
> limits defined on per container basis.  This basically allows a single
> platform to be (soft) partitioned among different workloads (each of
> which could be running many tasks).  The limits could be amount of
> memory, number of tasks among other features.  These two features are
> already implemented in the patch set that I posted.  But it is possible
> to add other controllers like CPU that allows only finite amount of time
> to the processes belonging to a container.
> 
> Currently this patch set is only tracking user memory (both file based
> and anonymous).  The memory handler is currently deactivating pages
> belonging to a container that has gone over the limit. Even though this
> allows containers to go over board their limits but 1- once they are
> over the limit then they run in degraded manner and 2- if there is any
> memory pressure then the (extra) pages belonging to this container are
> the prime candidates for swapping (for example).  The statistics that
> are shown in each container directory are the current values of each
> resource consumption.
> 
> Please let me know if you need any more specific information about the
> patch set.

A general description for the containers needs to go into Documentation/
along with the usage example, so that potential users know what to do
with it. The above seems fine, just remove the "this patch" references.

Björn
