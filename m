Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVALTM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVALTM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVALTKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:10:22 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:48568 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261305AbVALTGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:06:14 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11-rc1 -- usb_storage and Genesys
Date: Wed, 12 Jan 2005 20:06:33 +0100
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
Cc: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       USB Storage list <usb-storage@lists.one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501122006.34720.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 06:09, Linus Torvalds wrote:

> Matthew Dharm:
>   o USB Storage: support 'bulk32' devices
>   o USB Storage: Increase Genesys delay

The Genesys increased delay in this patch causes strange issues, the USB 
disconnects after a while...

I rewrote the identifier like it was previous this patch

--
if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS &&
--

and it works like I expected it to...

Just a note.

Jan

-- 
Support your right to bare arms!
  -- A message from the National Short-Sleeved Shirt Association
