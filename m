Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264865AbUEJQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbUEJQhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbUEJQhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:37:12 -0400
Received: from mail1.kontent.de ([81.88.34.36]:4009 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264867AbUEJQgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:36:52 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hci-usb bugfix
Date: Mon, 10 May 2004 18:36:35 +0200
User-Agent: KMail/1.6.2
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org> <1084205974.9639.16.camel@pegasus>
In-Reply-To: <1084205974.9639.16.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405101836.35239.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Mai 2004 18:19 schrieb Marcel Holtmann:
> Hi Alan,
> 
> > It looks like the problem is that hci_usb_disconnect() is trying to do too 
> > much.  When called for the SCO interface it should simply return.
> 
> I came to the same conclusion, but I used the attached patch.

Which is wrong. It assumes that interfaces are disconnected in a certain
order, which happens only by chance in your case.

	Regards
		Oliver
