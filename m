Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTDNV32 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTDNV2j (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:28:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18863 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263956AbTDNV2d (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:28:33 -0400
Date: Mon, 14 Apr 2003 14:34:05 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414213405.GB5700@kroah.com>
References: <20030414190032.GA4459@kroah.com> <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com> <200304142311.01245.oliver@neukum.org> <3E9B2720.7020803@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9B2720.7020803@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 02:24:48PM -0700, Kevin P. Fleming wrote:
> 
> Personally, this is one reason why I'd much rather see a daemon-based model 
> where each interested daemon can "subscribe" to the messages it is 
> interested in. It's very possible (and likely, i.e. udev) that the steps 
> involved for the daemon to respond to the hotplug event are so lightweight 
> that creating a subprocess to handle them would be very wasteful.

One of the hotplug programs will create a D-BUS message that anyone can
subscribe to.  But I don't want to add that to one of the existing
hotplug programs, as it's a separate task.  That's one reason for the
proposed change.

thanks,

greg k-h
