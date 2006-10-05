Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWJEQeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWJEQeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWJEQen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:34:43 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:28894 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S932153AbWJEQem convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:34:42 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Thu, 5 Oct 2006 18:35:21 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0610051219500.6596-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610051219500.6596-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610051835.21704.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2006 18:21 schrieb Alan Stern:
> Currently we don't have any userspace APIs for such a daemon to use.  The 
> only existing API is deprecated and will go away soon.

I trust it'll be replaced.

> Current thinking is that a driver will suspend its device whenever the 
> device isn't in use.  With usblp, that would be whenever the device file 
> isn't open.  See the example code in usb-skeleton.c.

In the general case the idea seems insufficient. If I close my laptop's lid
I want all input devices suspended, whether the corresponding files are
opened or not. In fact, if I have port level power control I might even
want to cut power to them.

	Regards
		Oliver

