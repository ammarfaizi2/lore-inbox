Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTDKUpr (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbTDKUpr (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:45:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4561 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261825AbTDKUpo (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:45:44 -0400
Date: Fri, 11 Apr 2003 13:59:48 -0700
From: Greg KH <greg@kroah.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411205948.GV1821@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com> <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 01:48:17PM -0700, David Lang wrote:
> ant then you also have all the same problems as devfs about default
> permissions, making permissions persistant across reboots, etc.

You can store the default permissions in the database you use to store
the naming data.  This solves the reboot problem, as long as you can
convince people to not modify the permissions on their own (well even if
they do, at shutdown, you can always validate that they are the same
before you clean up the node.)

And provide an easy way for users to change the permissions so they show
up in the database.

devchmod and devchown anyone?  :)

thanks,

greg k-h
