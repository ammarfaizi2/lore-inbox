Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWJ3PbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWJ3PbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWJ3PbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:31:07 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:63057 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030533AbWJ3PbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:31:06 -0500
Message-ID: <454619B9.8030705@openvz.org>
Date: Mon, 30 Oct 2006 18:26:49 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, menage@google.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com>	<45460743.8000501@openvz.org>	<20061030062332.856dcc32.pj@sgi.com>	<45460E69.7070505@openvz.org> <20061030071838.7988d3e1.pj@sgi.com>
In-Reply-To: <20061030071838.7988d3e1.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Pavel wrote:
>>>> 3. Configfs may be easily implemented later as an additional
>>>>    interface. I propose the following solution:
>>>>      ...
>> Resource controller has nothing common with confgifs.
>> That's the same as if we make netfilter depend on procfs.
> 
> Well ... if you used configfs as an interface to resource
> controllers, as you said was easily done, then they would
> have something to do with each other, right ;)?

Right. We'll create a dependency that is not needed.

> Choose the right data structure for the job, and then reuse
> what fits for that choice.
> 
> Neither avoid nor encouraging code reuse is the key question.
> 
> What's the best fit, long term, for the style of kernel-user
> API, for this use?  That's the key question.

I agree, but you've cut some importaint questions away,
so I ask them again:

 > What if if user creates a controller (configfs directory)
 > and doesn't remove it at all. Should controller stay in
 > memory even if nobody uses it?

This is importaint to solve now - wether we want or not to
keep "empty" beancounters in memory. If we do not then configfs
usage is not acceptible.

 > The same can be said about system calls interface, isn't it?

I haven't seen any objections against system calls yet.
