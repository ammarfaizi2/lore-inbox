Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUBDWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUBDWBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:01:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:19344 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266577AbUBDWBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:01:04 -0500
Date: Wed, 4 Feb 2004 14:00:16 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 2013] New: Oops from create_dir (sysfs)
Message-ID: <20040204220016.GD3897@kroah.com>
References: <1075926442.3026.37.camel@verve> <20040204204811.GA3992@us.ibm.com> <1075928072.3026.47.camel@verve> <20040204212253.GA3897@kroah.com> <1075931022.3026.63.camel@verve>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075931022.3026.63.camel@verve>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 03:43:42PM -0600, John Rose wrote:
> <crickets chirp>.  That's one way to shut me up :)

Honestly, I like the way this currently works.  You tried to do
something not allowed, and the kernel dies.  Now it would be nice to be
able to provide a better type of error message to help the unsuspecting
developer out, but that's just fluff :)

> In all seriousness, how much of a performance problem would be posed by
> throwing a kset_find_obj() check somewhere in the beginning of
> kobject_add()? 

Why not just fix the sysfs create_dir() function to not oops and report
back the proper error message in this case?

thanks,

greg k-h
