Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSJZQ5f>; Sat, 26 Oct 2002 12:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSJZQ5f>; Sat, 26 Oct 2002 12:57:35 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:11911 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261208AbSJZQ5f> convert rfc822-to-8bit; Sat, 26 Oct 2002 12:57:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Kevin Brosius <cobra@compuserve.com>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-ac3 usb audio - illegal sleep call
Date: Sat, 26 Oct 2002 19:02:32 +0200
User-Agent: KMail/1.4.3
References: <3DBAA320.B02AB7FC@compuserve.com>
In-Reply-To: <3DBAA320.B02AB7FC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210261902.32626.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 26. Oktober 2002 16:13 schrieb Kevin Brosius:
> I've been trying to get USB up to test a audio device and just managed
> to get it all working to some extent.  When using xmms to play audio
> (usb audio module - oss soundcore) I see the following kernel messages
> repeatedly, maybe once a second or so:

Go edit usbout_completed() and usbin_completed(). Change the GFP_KERNEL
in usb_submit_urb to GFP_ATOMIC.
Does that help ?

	Regards
		Oliver

