Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJFMeW>; Sun, 6 Oct 2002 08:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSJFMeW>; Sun, 6 Oct 2002 08:34:22 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:57458 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S261593AbSJFMeV>; Sun, 6 Oct 2002 08:34:21 -0400
Message-Id: <m17yAhF-006i5XC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "John Tyner" <jtyner@cs.ucr.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Sun, 6 Oct 2002 12:11:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <001c01c26ce4$39b67f80$0a00a8c0@refresco>
In-Reply-To: <001c01c26ce4$39b67f80$0a00a8c0@refresco>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 October 2002 04:58, John Tyner wrote:
> This time with the patch actually attached!

In vicam_v4l_open:

Why is only the first control message checked for errors?

vicam_usb_probe:

__devinit ???

vicam_usb_disconnect:

__devexit ???
And you should probably kill the tasklet before you unregister the video 
device.

	Regards
		Oliver

PS: Is that just me, or did diff produce particularly unreadable output this 
time?
