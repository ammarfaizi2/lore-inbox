Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbTFERD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbTFERD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:03:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:929 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264772AbTFERDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:03:24 -0400
Date: Thu, 5 Jun 2003 10:18:35 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605171835.GC5424@kroah.com>
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com> <20030605083815.GA16879@suse.de> <20030605084933.GI2329@kroah.com> <20030605085938.GC16879@suse.de> <20030605090645.GA2887@kroah.com> <20030605091802.GA17356@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605091802.GA17356@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:18:02AM +0100, Dave Jones wrote:
> 
> The fact that a tree-wide 'cleanup' like this goes in just a few hours
> after its posted before chance to comment is another argument, but
> concentrating on the technical point here, I still think this is a
> step backwards.

Why?  I just got rid of a function (well macro) that isn't even needed
(as proven by replacing it with an existing function.)  That's
technically a good thing :)

Now I can agree that some of those replacements could be done with a
different function call, as almost none of the replacements in the
driver/* tree really want to walk all of the pci devices in the tree.
They usually just want to walk all devices of a type of pci device (be
it capability, or other trait.)  I'd be glad to take changes of this
sort in the future.

thanks,

greg k-h
