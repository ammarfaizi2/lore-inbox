Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUI2To5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUI2To5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUI2To5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:44:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:16570 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267703AbUI2Tke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:40:34 -0400
Subject: Re: kobject events questions
From: Robert Love <rml@novell.com>
To: Timo =?ISO-8859-1?Q?Ter=E4s?= <ext-timo.teras@nokia.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <415ABA96.6010908@nokia.com>
References: <415ABA96.6010908@nokia.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 29 Sep 2004 15:39:09 -0400
Message-Id: <1096486749.4666.31.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 16:37 +0300, Timo Teräs wrote:

> 1) Send the events so that they are always associated with the network 
> devices class_device kobject. I guess this would be quite clean way to 
> do it, but it'd require adding a new signal type and would limit the 
> iptables target to be associated always with a interface.
> 
> 2) Create a device class that has virtual timer devices that trigger 
> events (ie. /sys/class/utimer). Each timer could have some attributes 
> (like expired, expire_time, etc.) and would emit "change" signals 
> whenever timer expires.
> 
> I'd like to hear what you think of the thing I'm trying to do?
> 
> And especially how "bad" idea the option 2 is (since the new class might 
> not be useful for others)?

Well, #1 is the intention and spirit of the kevent system.

And adding a new signal type is fine.

So the only downside is that the table to interface association thing.
I have no idea how big an issue that is for you.

You could of course create a new kobject, ala #2, but that does not seem
optimal if the object is otherwise worthless.  I don't think that you
should create a new class.  Better to put something under /sys/net
related to what you are doing.

	Robert Love


