Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVBBG1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVBBG1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 01:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVBBG1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 01:27:34 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:49829 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262046AbVBBG0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 01:26:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Victor Hahn <victorhahn@web.de>
Subject: Re: Really annoying bug in the mouse driver
Date: Wed, 2 Feb 2005 01:26:37 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <41E91795.9060609@web.de> <200502011819.12304.dtor_core@ameritech.net> <42006E79.7070503@web.de>
In-Reply-To: <42006E79.7070503@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502020126.37621.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 February 2005 01:08, Victor Hahn wrote:
> Dmitry Torokhov wrote:
> 
> >Any luck with the patch?
> >
> 
> I'm using 2.6.11rc2 with the patch for some hours now and it seems as if 
> it doesn't throw away bytes any more which makes linux 2.6 useable for 
> me again - thanks a lot!

It still complains in dmesg about throwing away bytes, right? Please try
loading the box some more to make sure mouse survives some abuse.

> I just encountered one smaller issue (this  
> really is much better than before): The mouse just "jumped" once and 
> then got back to normal immediately. This gives me the following message 
> in /var/log/messages:
> 
> kernel: psmouse.c: bad data from KBC - bad parity
> 

Your keyboard controller reported that the byte transmitted from the mouse
was mangled somehow and we should not trust it. I am not sure why it would
make mouse jump.. was there any mention of "reconnect" in the logs? Did it
happen just once?

-- 
Dmitry
