Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUEJRTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUEJRTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUEJRTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 13:19:20 -0400
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264335AbUEJRTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 13:19:19 -0400
Date: Mon, 10 May 2004 13:19:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Marcel Holtmann <marcel@holtmann.org>
cc: Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hci-usb bugfix
In-Reply-To: <1084205974.9639.16.camel@pegasus>
Message-ID: <Pine.LNX.4.44L0.0405101317180.669-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Marcel Holtmann wrote:

> Hi Alan,
> 
> > It looks like the problem is that hci_usb_disconnect() is trying to do too 
> > much.  When called for the SCO interface it should simply return.
> 
> I came to the same conclusion, but I used the attached patch.
> 
> > Does this patch improve the situation?
> 
> Not tested ;)

Better not test it -- I just noticed that without your patch installed the 
driver would try to dereference a NULL pointer!  Probably the safest 
approach is to use both patches.

Alan Stern

