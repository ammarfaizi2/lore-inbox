Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUEGMCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUEGMCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 08:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUEGMCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 08:02:09 -0400
Received: from sonolo.xs4all.nl ([80.126.206.91]:28676 "EHLO sendmail.metro.cx")
	by vger.kernel.org with ESMTP id S263565AbUEGMCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 08:02:06 -0400
Date: Fri, 7 May 2004 14:02:02 +0200
From: kernel@metro.cx
To: linux-kernel@vger.kernel.org
Subject: USB gadgets, small bug
Message-ID: <20040507120202.GA9221@metro.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I don't know where else to report this, but I found a very very very
minor bug in the usb gadgets drivers, specifically the file_storage.c
mass storage driver.

In the function do_request_sense(..) it says:

buf[7] = 18 - 7;                        // Additional sense length

Whereas (according to page 38 of the USB mass storage class, UFI command spec,
http://www.usb.org/developers/devclass_docs#approved) this clearly neads
to be equal to 10, not 11.

I checked with the 2.6.5 source, it is still there. Hope someone will find this usefull, although most USB hosts seem to ignore length bits alltogether anyway....

Koen Martens

-- 
http://www.sonologic.nl/
