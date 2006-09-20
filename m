Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWITXgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWITXgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWITXgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:36:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27080 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750700AbWITXgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:36:35 -0400
Date: Wed, 20 Sep 2006 16:36:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Paul Jackson <pj@sgi.com>, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158795231.7207.21.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201634450.1955@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> 
 <1158773208.8574.53.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com> 
 <1158775678.8574.81.camel@galaxy.corp.google.com>  <20060920155815.33b03991.pj@sgi.com>
  <Pine.LNX.4.64.0609201601450.1026@schroedinger.engr.sgi.com>
 <1158795231.7207.21.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> > How does the containers implementation under discussion behave if a 
> > process is part of a container and the container is removed?
> It first removes all the tasks belonging to this container (which means
> resetting the container pointers in task_struct and then per page
> container pointer belonging to anonymous pages).  It then clears the
> container pointers in the mapping structure and also in the pages
> belonging to these files.

So the application continues to run unharmed?

Could we equip containers with restrictions on processors and nodes for 
NUMA?

