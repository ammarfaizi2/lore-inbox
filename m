Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317187AbSFWW7L>; Sun, 23 Jun 2002 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317188AbSFWW7K>; Sun, 23 Jun 2002 18:59:10 -0400
Received: from pallas.or.intel.com ([134.134.214.21]:8959 "EHLO
	pallas.or.intel.com") by vger.kernel.org with ESMTP
	id <S317187AbSFWW7K>; Sun, 23 Jun 2002 18:59:10 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F52@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Nick Bellinger'" <nickb@attheoffice.org>,
       David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map)
Date: Sun, 23 Jun 2002 15:59:04 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nick Bellinger [mailto:nickb@attheoffice.org] 
> Giving the IP stack its own directory (leaf?) under driverfs 
> root sounds
> interesting enough and could have some potential uses, but in the case
> of iSCSI there are a few problems:

I know this is one of those things that has more and more cool possibilities
the more you think about it but...

Is the device PHYSICALLY hooked up to the computer? If not, it shouldn't be
in devicefs.

The device tree (for which devicefs is the fs representation) was originally
meant to enable good device power management and configuration. driverfs
wasn't meant to handle iscsi or tcpip (that is, network) connections, nor
should it have to.

Regards -- Andy
