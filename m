Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUFPRhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUFPRhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUFPRhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:37:13 -0400
Received: from fmr05.intel.com ([134.134.136.6]:48095 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264275AbUFPRhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:37:07 -0400
Date: Wed, 16 Jun 2004 10:36:38 -0700
From: Rusty Lynch <rusty@linux.jf.intel.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: "Sabharwal, Atul" <atul.sabharwal@intel.com>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Announce] Non Invasive Kernel Monitor for threads/processes
Message-ID: <20040616173638.GA29548@penguin2.jf.intel.com>
References: <66539F0E7F15B44C9C0FC50D0FF024F7B1A324@orsmsx407> <40D058F3.5070109@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D058F3.5070109@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 10:28:03AM -0400, Chris Friesen wrote:
> Sabharwal, Atul wrote:
> 
> >How does auditing work in the event of a process failure ? There would
> >be
> >no system call triggered in that case.  Also, my initial thoughts are
> >that the non-invasive Kmonitor is lesser performance impact when
> >compared
> >to auditing. I would spend some time developing sample code to confirm
> >it.
> 
> Just to put in my $.02.  We developed a very simple (even simpler than 
> Kmonitor in that it didn't track fork/exec) way for a process to get 
> notified when other processes exited (properly or otherwise).  We want to 
> use this in the field for a lifecycle monitoring function (a sort of 
> super-init) so it needs to be as lightweight as possible.  I'd love to be 
> able to use something from the mainline kernel, but it has to be 
> field-runnable without slowing stuff down.
> 
> Chris

I think your requriement is the core requirement that we were tackling, and
the tracking for fork/exec was more of a feature creap thing.

So far suggestions include...

PAGG: never heard of it, but will look into it
LTT: I think this will cause too much overhead from all the hooks that
     we don't need, but we need to verify this.
Auditing:  Working on some very simple examples to understand how to use
           this correctly, and to understand if this is good enough, or if
           there are some modifications that could be made that would make it
           fit this very limited use of auditing.

    --rusty
