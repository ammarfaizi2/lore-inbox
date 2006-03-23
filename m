Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWCWIou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWCWIou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWCWIou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:44:50 -0500
Received: from mx.pathscale.com ([64.160.42.68]:49036 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964893AbWCWIou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:44:50 -0500
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, openib-general@openib.org
In-Reply-To: <20060323054905.GB20672@kroah.com>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
	 <20060323054905.GB20672@kroah.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 00:44:45 -0800
Message-Id: <1143103485.6411.14.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 21:49 -0800, Greg KH wrote:

> Why are you testing kobj.dentry in these functions?

I think this is a holdover from an earlier version of the driver that
didn't clean up properly after driver registration failed.  In other
words, those tests are no longer needed.  Thanks for spotting this.

> Oh, and I like your new filesystem, but where do you propose that it be
> mounted?

I don't have any good candidates in mind.  In our development
environment, we're mounting it in /ipath, but that doesn't seem like a
good long-term name.  Do you have any suggestions?

> You leak a group if the second call to sysfs_create_group() fails for
> some reason.

Thanks.

	<b

