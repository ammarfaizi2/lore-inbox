Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVEBQ7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVEBQ7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEBQyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:54:02 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:11348 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261516AbVEBQwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:52:39 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: stuffing characters to keyboard buffer.
Date: Mon, 2 May 2005 11:52:19 -0500
User-Agent: KMail/1.8
Cc: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505022126520.5301@lantana.cs.iitm.ernet.in>
In-Reply-To: <Pine.LNX.4.60.0505022126520.5301@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505021152.19778.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Monday 02 May 2005 11:29, P.Manohar wrote:
> 
> hai,
>        I want to stuff the characters received on a serial line into the 
> keyboard buffer, so that they will be send to applications as if they are 
> coming from keyboard irrespective of console or x-windows mode.
> 
>        For this purpose, I planned to use ioctls. Can anybody tell how to 
> send an ioctl to keyboard driver?
>

If you are working with 2.6 you'd need to create an input device, probably
working on top of serport driver, like sermouse does. You may also want to
take a look at uinput driver - it allows to create userspace-driven input
devices.

-- 
Dmitry
