Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVASWSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVASWSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVASWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:16:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:23548 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261947AbVASWOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:14:37 -0500
Date: Wed, 19 Jan 2005 13:39:38 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pawlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/2] Remove input_call_hotplug
Message-ID: <20050119213938.GB4151@kroah.com>
References: <41ED23A3.5020404@suse.de> <20050118213002.GA17004@kroah.com> <d120d50005011813495b49907c@mail.gmail.com> <20050118215820.GA17371@kroah.com> <d120d500050118142068157a78@mail.gmail.com> <20050119013133.GD23296@kroah.com> <41EE4AE0.9030308@suse.de> <d120d500050119063040de00a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050119063040de00a7@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:30:14AM -0500, Dmitry Torokhov wrote:
> If I understand correctly we do not have subclasses so it will look like
> class
> |- input_device
> |  |- input0
> |  |- input1
> |
> |- input
> |  |-event0
> |  |-event1
> |  |-mouse0
> 
> So breakage is really minimal.

I really want classes to be able to have "parent" classes someday.  It's
not that tough of a change to the driver core, if someone wants to do
the work.  That would enable this input stuff to be cleaner, right?

It would also allow us to move the /sys/block stuff to use classes,
which it can't right now due to the lack of the parent ability.

thanks,

greg k-h
