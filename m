Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266587AbUBDUwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUBDUt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:49:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:27374 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266589AbUBDUrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:47:52 -0500
Date: Wed, 4 Feb 2004 12:48:11 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 2013] New: Oops from create_dir (sysfs)
Message-ID: <20040204204811.GA3992@us.ibm.com>
References: <1075926442.3026.37.camel@verve>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075926442.3026.37.camel@verve>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.2 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 02:27:22PM -0600, John Rose wrote:
> In the last couple of weeks, I've come across this crash a few times. 
> In each case, my code was kobject_add()'ing a kobject to a kset that
> already contained a kobject of the same name.
> 
> Granted that these additions reflected faulty logic on the part of my
> code, but I was suprised that kobject_add didn't have a more intelligent
> response than crashing while creating the redundant sysfs dir.
> 
> Thoughts?

The kobject code quickly pointed out the flaw in your code.  Sounds like
the proper response to me :)

thanks,

greg k-h
