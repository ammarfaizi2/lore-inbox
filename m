Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTDXBEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 21:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTDXBEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 21:04:14 -0400
Received: from mail.ccur.com ([208.248.32.212]:22793 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264305AbTDXBEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 21:04:14 -0400
Date: Wed, 23 Apr 2003 21:16:17 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Nils Holland <nils@ravishing.de>
Cc: David van Hoose <davidvh@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
Message-ID: <20030424011616.GA11649@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <3EA6C558.5040004@cox.net> <20030423201619.GB12889@kroah.com> <3EA707D2.1000507@cox.net> <200304240034.20872.nils@ravishing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304240034.20872.nils@ravishing.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Nils,

Nils, you have

	CONFIG_USB_HIDINPUT=y

which is correct.  David, you have

	CONFIG_USB_HIDINPUT=m

which is an illegal setting.  You must have hand-edited your config file
to get this.  My guess is, the '=m' is being treated as 'not set'.

You also need to have CONFIG_INPUT (Input core support section) set.
If this is not set you will not see the CONFIG_USB_HIDINPUT question
come up in the USB section.

Regards,
Joe
