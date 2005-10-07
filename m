Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbVJGSIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbVJGSIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVJGSIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:08:21 -0400
Received: from [81.2.110.250] ([81.2.110.250]:21919 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030543AbVJGSIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:08:20 -0400
Subject: Re: [RFClue] pci_get_device, new driver model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4346ADD7.9010604@beezmo.com>
References: <43469FB8.50303@beezmo.com>
	 <1128706111.18867.8.camel@localhost.localdomain>
	 <4346ADD7.9010604@beezmo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Oct 2005 19:36:37 +0100
Message-Id: <1128710197.18867.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-07 at 10:18 -0700, William D Waddington wrote:
> Is it ever possible that the hotplug stuff will try to remove and re-add
> one (or all) of my boards when there _hasn't_ been a physical change or
> power cycle/reboot/driver reload/whatever.

Only if the user does it deliberately.

> Still not quite clear how to assocuiate instance/minor #s with boards.
> Do I just keep a global counter and bump it each time probe (or init)
> gets called for each board?  Hence my worry above.

It really is up to you. Most drivers just issue the first free minor
number.

Alan
