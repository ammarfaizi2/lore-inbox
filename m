Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTIANpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbTIANpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:45:55 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:33760 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S262892AbTIANpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:45:47 -0400
Subject: Re: request_firmware() backport to 2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309011022140.2504-100000@logos.cnet>
References: <Pine.LNX.4.44.0309011022140.2504-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2003 15:45:26 +0200
Message-Id: <1062423932.30893.148.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

> > > Now bfusb loads "bfubase.frm", but stock kernel has no such thing. 
> > > 
> > > I assume that breaks bfusb?
> > 
> > no, the bfubase.frm is the original firmware file from AVM. This file
> > have to be placed somewhere on the filesystem. 
> 
> Right, and without placing the file somewhere on the filesystem bfusb
> 2.4.22 users wont have 2.4.23 working without "issues".

this is correct, but the firmware in bfusb.h of 2.4.22 is outdated and
it have some problems which are fixed in the newer firmware versions.

The development progress in Bluetooth is very fast at the moment and the
companies are fixing the problems with their own schedule. The driver
interface of the bfusb.o is clean and stable and in the most cases we
have no chance to workaround any problems in the Bluetooth firmware,
because we don't have access to the link manager. A new firmware means
recompile and pushing you a new bfusb.h (after I got the permission from
AVM) and this can happen very often in a 2.4.x release cycle.

> But well, I dont know if I should care that much. 

I already thought about it, because the request_firmware() can report
back if a firmware file is not found and in this case it can load the
included firmware. But as stated above the firmware is outdated and so I
decided to remove it completly.

Regards

Marcel


