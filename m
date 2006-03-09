Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWCINde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWCINde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWCINde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:33:34 -0500
Received: from tim.rpsys.net ([194.106.48.114]:50852 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751885AbWCINdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:33:33 -0500
Subject: Re: [rfc] separate sharpsl_pm initialization from sysfs code
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, lenz@cs.wisc.edu
In-Reply-To: <20060309124237.GA3794@elf.ucw.cz>
References: <20060309124237.GA3794@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 13:33:21 +0000
Message-Id: <1141911202.10107.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 13:42 +0100, Pavel Machek wrote:
> Hi!
> 
> On collie, battery sensing code is not on platform bus -- it is on
> ucb1x00. Is this acceptable way to make sharpsl_pm useful for collie?
> It separates code that is bus-independent, so collie can call only
> code it needs.

I'm not sure why the battery sensing code being on a non-platform bus
prevents you from registering a platform device as mentioned in my other
email? If you register the device, you then get the benefit of all the
features of the common code like the sysfs attributes and common
charging code. Its not really designed to be used outside the device
model and I suspect trying to do so is just going to mean lots more
nasty changes to it in the future...

Richard

