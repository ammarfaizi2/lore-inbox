Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWITXjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWITXjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWITXjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:39:53 -0400
Received: from smtp-out.google.com ([216.239.45.12]:55336 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750728AbWITXjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:39:52 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=PBzpEGDD50KPGw71JmdNbO97uWOZnGD7OqvTdJqY3qn4iKEafkQdNUKXevNlrX/OM
	OiL5b8a5QBejbvri1/c2A==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, npiggin@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609201634450.1955@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	 <1158775678.8574.81.camel@galaxy.corp.google.com>
	 <20060920155815.33b03991.pj@sgi.com>
	 <Pine.LNX.4.64.0609201601450.1026@schroedinger.engr.sgi.com>
	 <1158795231.7207.21.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201634450.1955@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 16:39:29 -0700
Message-Id: <1158795569.7207.23.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 16:36 -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Rohit Seth wrote:
> 
> > > How does the containers implementation under discussion behave if a 
> > > process is part of a container and the container is removed?
> > It first removes all the tasks belonging to this container (which means
> > resetting the container pointers in task_struct and then per page
> > container pointer belonging to anonymous pages).  It then clears the
> > container pointers in the mapping structure and also in the pages
> > belonging to these files.
> 
> So the application continues to run unharmed?
> 

It will hit a one time penalty of getting those pointers reset, but
besides that it will continue to run fine.

> Could we equip containers with restrictions on processors and nodes for 
> NUMA?
> 

Yes.  That is something we will have to do (I think part of CPU
handler-TBD).

-rohit

