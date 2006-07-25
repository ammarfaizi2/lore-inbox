Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWGYWAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWGYWAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWGYWAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:00:31 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:55446 "EHLO
	asav04.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1030200AbWGYWAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:00:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAPQvxkSBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC PATCH] Multi-threaded device probing
Date: Tue, 25 Jul 2006 18:00:24 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
References: <20060725203028.GA1270@kroah.com>
In-Reply-To: <20060725203028.GA1270@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251800.25328.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 16:30, Greg KH wrote:
> During the kernel summit, I was reminded by the wish by some people to
> do device probing in parallel, so I created the following patch.  It
> offers up the ability for the driver core to create a new thread for
> every driver<->device probe call.  To enable this, the driver needs to
> have the multithread_probe flag set to 1, otherwise the "traditional"
> sequencial probe happens.
> 

Another option would be to have probing still serialized within a bus but
serviced by a separate thread. The thread can die after let's say 1 minute
inactivity timeout and respawned if needed.

-- 
Dmitry
