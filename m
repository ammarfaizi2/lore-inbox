Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274970AbTHADMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 23:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274971AbTHADMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 23:12:34 -0400
Received: from user-10cm126.cable.mindspring.com ([64.203.4.70]:22023 "HELO
	cia.zemos.net") by vger.kernel.org with SMTP id S274970AbTHADMd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 23:12:33 -0400
Date: Thu, 31 Jul 2003 20:13:33 -0700 (PDT)
From: Gorik Van Steenberge <gvs@cia.zemos.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 usb-storage problem
In-Reply-To: <Pine.LNX.4.50L0.0307311948100.2728-100000@cia.zemos.net>
Message-ID: <Pine.LNX.4.50L0.0307312009410.3016-100000@cia.zemos.net>
References: <Pine.LNX.4.50L0.0307311948100.2728-100000@cia.zemos.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello again,


I found what I did to cause that bug...

If you modprobe usb_storage, then rmmod it, and modprobe it again you have
two "usb_storage" entries in /proc/scsi.

I would assume that somewhere it doesn't unregister from /proc when
unloading the module?


Hope this helps,

Gorik
