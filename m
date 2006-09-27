Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWI0FDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWI0FDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWI0FDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:03:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:44938 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965261AbWI0FDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:03:22 -0400
Date: Tue, 26 Sep 2006 21:56:11 -0700
From: Greg KH <greg@kroah.com>
To: Ed Swierk <eswierk@arastra.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [RETRY] [PATCH] load_module: no BUG if module_subsys uninitialized
Message-ID: <20060927045611.GC32644@kroah.com>
References: <c1bf1cf0609221248v39113875id4b48c62cec8eb46@mail.gmail.com> <20060922201637.GA17547@kroah.com> <c1bf1cf0609221428i618a5902g3d0315f6b0b9b79e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bf1cf0609221428i618a5902g3d0315f6b0b9b79e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 02:28:57PM -0700, Ed Swierk wrote:
> On 9/22/06, Greg KH <greg@kroah.com> wrote:
> >How are you calling load_module before this init call is made?
> 
> In my case, net-pf-1 is getting modprobed as a result of hotplug
> trying to create a UNIX socket. Calls to hotplug begin after the
> topology_init initcall.

So, with this patch the module will still not be loaded properly, right?
Well, I guess at least we don't oops... ok.

thanks,

greg k-h
