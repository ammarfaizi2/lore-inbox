Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSFUAkY>; Thu, 20 Jun 2002 20:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSFUAkW>; Thu, 20 Jun 2002 20:40:22 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:31637 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316070AbSFUAkV>; Thu, 20 Jun 2002 20:40:21 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map 
Date: Thu, 20 Jun 2002 18:28:01 +0200
Message-Id: <20020620162801.24988@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.44.0206201210420.8225-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0206201210420.8225-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Absolutely. I suspect that the _real_ issues start coming up only once
>people start using this for useful work, and we should just accept that
>the format (for now) is in flux. But that doesn't mean that we shouldn't
>try to make it reasonably sane from the very start.
>
>And make sure that the naming convention works for both IDE and SCSI (ie
>there should be a way to figure out _portably_ whether a device is a disk
>or CD-RW or whatever, without even knowing whether it's SCSI or IDE).

Looking at how other kind of device trees are doing (typically
Open Firmware), I beleive this can be acheived by having a "type"
node (ie. file).

Also, there are lots of good reasons to put device/driver settings as
"properties" of the device node in the device tree, which ends up having
proc-like files under each device node.
We could define some standard ones (like the device type) and provide a
simple way (proc-like) for drivers to add more properties, thus replacing
in most cases the need for ioctls.

Ben.


