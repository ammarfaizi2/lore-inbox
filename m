Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270905AbTGNVRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270903AbTGNVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:16:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:8922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270883AbTGNVPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:15:23 -0400
Date: Mon, 14 Jul 2003 14:29:41 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] One more USB update for 2.4.22-pre5
Message-ID: <20030714212941.GB1501@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Right after I send out the last USB updates, I got this one from the
usb-storage people.  It seems pretty serious, so I'm sending this one
out as a single patch.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patch will be sent in a follow up message to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/storage/protocol.c |   21 +++++++++++++++------
 drivers/usb/storage/usb.h      |    2 +-
 2 files changed, 16 insertions(+), 7 deletions(-)
-----

ChangeSet@1.1118, 2003-07-14 13:52:30-07:00, stern@rowland.harvard.edu
  [PATCH] USB: usb-storage US_FL_FIX_CAPACITY fix
  
  Pat LaVarre uncovered a bug where you could throw a well-formed (but
  arguably meaningless) INQUIRY command at a device via the sg interface
  and OOPS the usb-storage driver.  This prevents that from happening.
  
  This has been in 2.5 for a while now.  A 2.4 backport is probably a good
  thing.

 drivers/usb/storage/protocol.c |   21 +++++++++++++++------
 drivers/usb/storage/usb.h      |    2 +-
 2 files changed, 16 insertions(+), 7 deletions(-)
------


Alan Stern:
  o USB: usb-storage US_FL_FIX_CAPACITY fix

