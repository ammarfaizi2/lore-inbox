Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWITX1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWITX1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWITX1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:27:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:10789 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750837AbWITX1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:27:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=Kix+MK3Ae6wDlIPb77+ZUwuTJU4fAvbCBIpGAOQlI3Yx2iDg1LTx2c5/7bPl01/V9
	AxUWhjCVtH974TE61+KXw==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Paul Jackson <pj@sgi.com>
Cc: clameter@sgi.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060920155815.33b03991.pj@sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	 <1158775678.8574.81.camel@galaxy.corp.google.com>
	 <20060920155815.33b03991.pj@sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 16:26:48 -0700
Message-Id: <1158794808.7207.14.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 15:58 -0700, Paul Jackson wrote:
> Seth wrote:
> > So now we depend on getting memory hot-plug to work for faking up these
> > nodes ...for the memory that is already present in the system. It just
> > does not sound logical.
> 
> It's logical to me.  Part of memory hotplug is adding physial memory,
> which is not an issue here.  Part of it is adding another logical
> memory node (turning on another bit in node_online_map) and fixing up
> any code that thought a systems memory nodes were baked in at boottime.
> Perhaps the hardest part is the memory hot-un-plug, which would become
> more urgently needed with such use of fake numa nodes.  The assumption
> that memory doesn't just up and vanish is non-trivial to remove from
> the kernel.  A useful memory containerization should (IMHO) allow for
> both adding and removing such containers.
> 

Absolutely.  Since these containers are not (hard) partitioning the
memory in any way so it is easy to change the limits (effectively
reducing and increasing the memory limits for tasks belonging to
containers).  As you said, memory hot-un-plug is important and it is
non-trivial amount of work.

-rohit

