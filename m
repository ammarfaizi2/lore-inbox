Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUDNNbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbUDNNbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:31:00 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17370 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264233AbUDNNa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:30:58 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 15:30:54 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr>
In-Reply-To: <200404141245.37101.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141530.54093.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. April 2004 12:45 schrieb Duncan Sands:
> The remaining three patches contain miscellaneous fixes to usbfs.
> This one fixes up the disconnect callback to only shoot down urbs
> on the disconnected interface, and not on all interfaces.  It also adds
> a sanity check (this check is pointless because the interface could
> never have been claimed in the first place if it failed, but I feel better
> having it there).

Well, I don't. If you care about it, add a WARN_ON().
Checking without consequences is bad.

	Regards
		Oliver

