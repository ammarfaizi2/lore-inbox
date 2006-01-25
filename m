Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWAYWnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWAYWnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAYWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:43:05 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:52148 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S932193AbWAYWnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:43:04 -0500
Date: Thu, 26 Jan 2006 00:43:11 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
In-reply-to: <1138228361.15295.55.camel@serpentine.pathscale.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Message-id: <20060125224311.GG27845@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
 <1138228361.15295.55.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 02:32:41PM -0800, Bryan O'Sullivan wrote:
> I've been flailing away at the ioctls in our driver, with a good degree
> of success.  However, one in particular is proving tricky:
> 
> >         Opening the /dev/ipath special file assigns an appropriate free
> >         unit (chip) and port (context on a chip) to a user process.
> >         Think of it as similar to /dev/ptmx for ttys, except there isn't
> >         a devpts-like filesystem behind it.  Once a process has
> >         opened /dev/ipath, it needs to find out which unit and port it
> >         has opened, so that it can access other attributes in /sys.  To
> >         do this, we provide a GETPORT ioctl.
> 
> I still don't see how to replace this with anything else without
> performing unnatural acts.

If this is all it does, why not keep it as a device file, where open()
assigns the resources, read() returns them, and close() frees them? no
ioctl necessary.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

