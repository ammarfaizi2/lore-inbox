Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTHOQlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270014AbTHOQfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:35:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:4254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269144AbTHOQcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:32:13 -0400
Date: Fri, 15 Aug 2003 09:30:05 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call drv->shutdown at rmmod
In-Reply-To: <1060937467.13316.39.camel@gaston>
Message-ID: <Pine.LNX.4.33.0308150929300.974-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is a problem of semantics here. Is shutdown() supposed to shutdown
> the hardware device (ie. low power) or just the driver ? If yes, then
> it's duplicate of the PM callbacks. My understanding of the shutdown()
> callback is that it was more than "stop driver activity, put device into
> idle state" to prepare for a shutdown/reboot (though we do also sleep
> IDE drives in this case, but this is because of that nasty cache flush
> issue).

You have it right - ->shutdown() is only supposed to queisce the device. 


	Pat

