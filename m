Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUGHOOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUGHOOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 10:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGHOOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 10:14:53 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55181 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263687AbUGHOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 10:14:50 -0400
Message-ID: <40ED56D0.1020102@nortelnetworks.com>
Date: Thu, 08 Jul 2004 10:14:40 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Teigland <teigland@redhat.com>
CC: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <20040708105338.GA16115@redhat.com>
In-Reply-To: <20040708105338.GA16115@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland wrote:

> I'm afraid the fencing issue has been rather misrepresented.  Here's 
> what we're
> doing (a lot of background is necessary I'm afraid.)  We have a symmetric,
> kernel-based, stand-alone cluster manager (CMAN) that has no ties to 
> anything
> else whatsoever.  It'll simply run and answer the question "who's in the
> cluster?" by providing a list of names/nodeids.
> 
> So, if that's all you want you can just run cman on all your nodes and 
> it'll
> tell you who's in the cluster (kernel and userland api's).  CMAN will 
> also do
> generic callbacks to tell you when the membership has changed.  Some 
> people can
> stop reading here.

I'm curious--this seems to be exactly what the cluster membership portion of the 
SAF spec provides.  Would it make sense to contribute to that portion of 
OpenAIS, then export the CMAN API on top of it for backwards compatibility?

It just seems like there are a bunch of different cluster messaging, membership, 
etc. systems, and there is a lot of work being done in parallel with different 
implementations of the same functionality.  Now that there is a standard 
emerging for clustering (good or bad, we've got people asking for it) would it 
make sense to try and get behind that standard and try and make a reference 
implementation?

You guys are more experienced than I, but it seems a bit of a waste to see all 
these projects re-inventing the wheel.

Chris
