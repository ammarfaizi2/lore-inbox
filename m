Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUAHWBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUAHWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:01:18 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:18859 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265615AbUAHWBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:01:17 -0500
Subject: RE: [PATCH] LSI Logic MegaRAID3 PCI ID [Was: MegaRAID on AMD64und
	er 2.6.1]
From: Chris Meadors <clubneon@hereintown.net>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC2A5@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC2A5@exa-atlanta.se.lsil.com>
Content-Type: text/plain
Message-Id: <1073599275.9027.63.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 17:01:15 -0500
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AeiDL-0000eC-LF*aQ/DBP6lJwI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 16:38, Mukker, Atul wrote:
> I have not followed this thread completly yet but both
> PCI_DEVICE_ID_MEGARAID and PCI_DEVICE_ID_MEGARAID3 are valid and both should
> be present. Look for their definitions in the header file or pci_ids.h

Yes, both of those are valid device IDs (which is probably why the
dropped 3 didn't get noticed right away, it still compiled).  But are
there any cards out there that bear LSI Logic's vendor ID (1000) and the
MegaRAID version 1 device ID (9010)?  I'm thinking not.

Since LSI just started making MegaRAID cards at version 3.  That is what
I ment was invalid, the full line, LSI + MEGARAID.  All cards with
LSI_LOGIC as the vendor will be MEGARAID3 (1960).

The older version of megaraid.c didn't include an LSI + MEGARAID, but
did have an LSI + MEGARAID3.  The new version was the other way around,
and didn't detect my card any longer.  In my first patch, I just added a
new ID.  But after a little thinking and back tracking, I figured it was
probably a copy and paste error, and the '3' was dropped from the device
ID.  A new defination wasn't needed, just a correction to the mis-copied
one.

-- 
Chris

