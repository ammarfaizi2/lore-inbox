Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbTDIIUK (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 04:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbTDIIUK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 04:20:10 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:16844 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262908AbTDIIUJ (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 04:20:09 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Dwaine_Garden@wsib.on.ca
Subject: Re: [linux-usb-devel] [PATCH] USB speedtouch: don't open a connection if no firmware
Date: Wed, 9 Apr 2003 10:31:37 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <OF50785981.C7D592CC-ON85256D02.007454B5-85256D02.007ACB50@wsib.on.ca>
In-Reply-To: <OF50785981.C7D592CC-ON85256D02.007454B5-85256D02.007ACB50@wsib.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304091031.37302.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 23:16, Dwaine_Garden@wsib.on.ca wrote:
> I have noticed with the usbvision code, that when a device like it's own
> is called.  Webcam (Bttv) and the usbvision device.   It take forever to
> load and initialize the driver.
>
> People complain it sometimes it takes two minutes.   At first I thought
> they were making up things.
>
> I have another video and audio capture device.   I only see problem when
> both device have their drivers loaded.
>
> I'm like you.  I'm going to get to removing all the MOD_INC_USE_COUNT;
> code.

Hi Dwaine, I don't understand your email too well, sorry.  Many USB devices
take a while before they are usable, because first you need to load some
firmware into them.  MOD_INC_USE_COUNT will not slow down initialisation.
It is to do with unloading the driver, and stops the driver being unloaded when
it would be dangerous to do so.

All the best,

Duncan.
