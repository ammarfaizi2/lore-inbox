Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUEJTPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUEJTPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUEJTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:15:46 -0400
Received: from mail1.kontent.de ([81.88.34.36]:15775 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261252AbUEJTPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:15:44 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hci-usb bugfix
Date: Mon, 10 May 2004 21:15:26 +0200
User-Agent: KMail/1.6.2
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org> <200405101836.35239.oliver@neukum.org> <1084207959.9639.23.camel@pegasus>
In-Reply-To: <1084207959.9639.23.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405102115.26504.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Mai 2004 18:52 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > > It looks like the problem is that hci_usb_disconnect() is trying to do too 
> > > > much.  When called for the SCO interface it should simply return.
> > > 
> > > I came to the same conclusion, but I used the attached patch.
> > 
> > Which is wrong. It assumes that interfaces are disconnected in a certain
> > order, which happens only by chance in your case.
> 
> why is it wrong? If interface 0 is disconnected first then we go into
> the disconnect routine and cleanup. But if interface 1 is disconnected
> first, we don't do anything and "wait" for the disconnect on first
> interface.

Which not necessarily will ever come. It is possible that just one
interface is disconnected.

	Regards
		Oliver
