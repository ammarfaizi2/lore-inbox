Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVJKD7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVJKD7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVJKD7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:59:15 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:13719 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751215AbVJKD7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:59:14 -0400
Date: Tue, 11 Oct 2005 00:00:28 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Message-ID: <20051011040028.GA21135@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
	Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509300032.50408.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 12:32:49AM -0500, Dmitry Torokhov wrote:
> 
> I firmly believe that creating sub-classes (which solves hotplug issues)
> and linking sub-class devices to their parent via 'device' link, much like
> we link top-level class device to their physical parent devices (which
> solves 2, 3 and 4) is much cleanier way. It provides everything that your
> implementation does plus allows different views useful for other tasks
> besides udev.

Hi Dmitry,

Could you please outline the class device requirements for the input
subsystem?  Specifically I'm interested in the class -> subclass layering.
I'm trying to understand what is needed and how the input subsystem should
be structured.

I can think of other subystems that might benefit from class layering.  One
example might be wireless cards: net and net/wireless.  In this case devices
that belong to class "wireless" would inherit all of the capabilities of the
"net" class and also implement the "wireless"-specific feature set.

Thanks,
Adam
