Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWJaA0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWJaA0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWJaA0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:26:23 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21187 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751319AbWJaA0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:26:21 -0500
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Paul Jackson <pj@sgi.com>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, menage@google.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
In-Reply-To: <454619B9.8030705@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	 <45460743.8000501@openvz.org>	<20061030062332.856dcc32.pj@sgi.com>
	 <45460E69.7070505@openvz.org> <20061030071838.7988d3e1.pj@sgi.com>
	 <454619B9.8030705@openvz.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Mon, 30 Oct 2006 16:26:17 -0800
Message-Id: <1162254377.2715.169.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 18:26 +0300, Pavel Emelianov wrote:
> Paul Jackson wrote:
> > Pavel wrote:
> >>>> 3. Configfs may be easily implemented later as an additional
> >>>>    interface. I propose the following solution:
> >>>>      ...
> >> Resource controller has nothing common with confgifs.
> >> That's the same as if we make netfilter depend on procfs.
> > 
> > Well ... if you used configfs as an interface to resource
> > controllers, as you said was easily done, then they would
> > have something to do with each other, right ;)?
> 
> Right. We'll create a dependency that is not needed.
> 
> > Choose the right data structure for the job, and then reuse
> > what fits for that choice.
> > 
> > Neither avoid nor encouraging code reuse is the key question.
> > 
> > What's the best fit, long term, for the style of kernel-user
> > API, for this use?  That's the key question.
> 
> I agree, but you've cut some importaint questions away,
> so I ask them again:
> 
>  > What if if user creates a controller (configfs directory)
>  > and doesn't remove it at all. Should controller stay in
>  > memory even if nobody uses it?

	Yes. The controller should stay in memory until userspace decides that
control of the resource is no longer desired. Though not all controllers
should be removable since that may impose unreasonable restrictions on
what useful/performant controllers can be implemented.

	That doesn't mean that the controller couldn't reclaim memory it uses
when it's no longer needed.

<snip>

Cheers,
	-Matt Helsley

