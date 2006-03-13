Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWCMTbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWCMTbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWCMTbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:31:23 -0500
Received: from ws1-2.us4.outblaze.com ([205.158.62.81]:4760 "EHLO
	ws1-2.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S932334AbWCMTbW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:31:22 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 13 Mar 2006 14:32:46 -0500
Subject: ISA "struct device"
X-Originating-Ip: 82.16.209.2
X-Originating-Server: ws1-2.us4.outblaze.com
Message-Id: <20060313193246.EEFF01F50C4@ws1-2.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am supporting various hardsid/catweasel cards that provide _probe
calls.  These _probe calls are called with struct pci_device and
friends that contain various information about bus, slot, id,
resources, etc.

I see that isa pnp does something similar and all this information is
appears via /sys presumably for utitilies to pick up and do nice
things with.

Am wondering what happens with non pnp isa (unfortunately nolonger
have an ISA machine to experiment with).  Currently in the driver I
just use request_region with a few known addresses, with a challange
respone mechanism to see if it is the right thing.  How does one go
about getting that into a nice, sensibly filled out "struct device"
object and register it with /sys, for it to do the right thing.
Are there any existing examples to follow?

Regards,
Simon

-- 
___________________________________________________
Play 100s of games for FREE! http://games.mail.com/

