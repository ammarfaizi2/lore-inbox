Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUEJRwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUEJRwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 13:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEJRwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 13:52:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:17668 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261210AbUEJRww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 13:52:52 -0400
Date: Mon, 10 May 2004 13:52:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Marcel Holtmann <marcel@holtmann.org>
cc: Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hci-usb bugfix
In-Reply-To: <1084210037.9639.31.camel@pegasus>
Message-ID: <Pine.LNX.4.44L0.0405101348080.669-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Marcel Holtmann wrote:

> Hi Alan,
> 
> actually I don't see a reason for using both patches, because I can't
> follow the point from Oliver that I've assumed a certain order of
> disconnect.

I can't follow his point either.  Maybe he forgot that when the main 
interface is disconnected the driver will release the SCO interface as 
well.

> However is it the best practice to claim additional interfaces with the
> private pointer set to NULL?

The private pointer can be set to anything at all, since it's private.  
If your driver doesn't need to use it, then set it to NULL.  Nobody else
will try to access the pointer when your driver has claimed the interface.

Alan Stern

