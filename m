Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWDEBs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWDEBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWDEBs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:48:59 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:60548 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750759AbWDEBs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:48:59 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 21:48:56 -0400
User-Agent: KMail/1.9.1
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Andrew Morton <akpm@osdl.org>
References: <44238489.8090402@keyaccess.nl> <20060404210048.GA5694@suse.de> <4432EF58.1060502@keyaccess.nl>
In-Reply-To: <4432EF58.1060502@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604042148.57286.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 18:12, Rene Herman wrote:
> To Dmitry, I see you saying "probe() failing is driver's problem. The 
> device is still there and should still be presented in sysfs.". No, at 
> least in the case of these platform drivers (or at least these old ISA 
> cards using the platform driver interface), a -ENODEV return from the 
> probe() method would mean the device is _not_ present (or not found at 
> least). NODEV.

Or you could separate device probing code from driver->probe(). BTW I think
that ->probe() is not the best name for that method. It really is supposed
to allocate resources and initialize the device so that it is ready to be
used, not to verify that device is present. The code that created device
shoudl've done that.

-- 
Dmitry
