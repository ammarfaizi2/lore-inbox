Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWCVKwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWCVKwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWCVKwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:52:00 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:43476 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750761AbWCVKv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:51:59 -0500
In-Reply-To: <1143023981.2955.54.camel@laptopd505.fenrus.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063801.949835000@sorel.sous-sol.org> <1143016837.2955.20.camel@laptopd505.fenrus.org> <1992b724e8540f8e532806076d07eb9e@cl.cam.ac.uk> <1143023981.2955.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a70f33dcf9a53dc75b44452132eb81d8@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Date: Wed, 22 Mar 2006 10:52:17 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 10:39, Arjan van de Ven wrote:

>> The intent is to allow remote management tools to trigger a clean
>> shutdown of the virtual machine. That requires us to notify to
>> userspace, and this function does that by exec'ing one of the standard
>> userspace programs. Given the trigger is received by the kernel in the
>> first instance I don't know a better way of doing this. And if this is
>> the best way, I don't think there is generic code in the kernel which
>> does the same thing.
>
>
> well this isn't really different from the normal ctrl-alt-delete right?
> I would strongly suggest to follow the normal ctrl-alt-del path.. that
> follows the normal convention sysadmins are used to.
> It's not "/sbin/poweroff" fwiw... at least not hardcoded. Following the
> normal ctrl-alt-del codepath gets all the policy out of this kind of
> thing as well..

Hmm... that will work okay for reboot, where SIGINT to init is probably 
a better strategy than what we do now. But we'd still need something 
special for halt/shutdown. We followed the same principle for this as 
sparc64/kernel/power.c.

  -- Keir

