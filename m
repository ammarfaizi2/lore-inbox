Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWANQWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWANQWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWANQWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:22:25 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:57814 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964792AbWANQWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:22:23 -0500
Date: Sat, 14 Jan 2006 11:18:25 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] kobject: don't oops on null kobject.name
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Message-ID: <200601141121_MC3-1-B5DD-2BA3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060114034404.GA23061@kroah.com>

On Fri, 13 Jan 2006, Greg KH wrote:

> > I applied your patch to prevent registration of objects with null names on
> > top of my patch, then applied this to see if my test still triggered, and
> > the message was printed:
> 
> What was the message?  What traceback?
> 
> So, I think the point is that it isn't a kobject_add() issue, right?

My message was printed:

        get_kobj_path_length: encountered NULL name

So an uninitialized kobject was passed to kobject_get_path().

This is likely a problem somewhere in IDE when "hdx=ide-scsi' is used.
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
