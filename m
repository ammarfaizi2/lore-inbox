Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVA1XX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVA1XX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVA1XX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:23:56 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:35704 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262818AbVA1XXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:23:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH] add driver matching priorities
Date: Fri, 28 Jan 2005 18:23:26 -0500
User-Agent: KMail/1.7.2
Cc: greg@kroah.com, rml@novell.com, linux-kernel@vger.kernel.org
References: <1106951404.29709.20.camel@localhost.localdomain>
In-Reply-To: <1106951404.29709.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501281823.27132.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 January 2005 17:30, Adam Belay wrote:
> Of course this patch is not going to be effective alone.  We also need
> to change the init order.  If a driver is registered early but isn't the
> best available, it will be bound to the device prematurely.  This would
> be a problem for carbus (yenta) bridges.
> 
> I think we may have to load all in kernel drivers first, and then begin
> matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> patch for that too.
> 

I disagree. The driver core should automatically unbind generic driver
from a device when native driver gets loaded. I think the only change is
that we can no longer skip devices that are bound to a driver and match
them all over again when a new driver is loaded.  

-- 
Dmitry
