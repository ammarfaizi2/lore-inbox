Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUBXTRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUBXTRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:17:42 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:26260 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262379AbUBXTRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:17:38 -0500
Date: Tue, 24 Feb 2004 13:16:14 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Greg KH <greg@kroah.com>
cc: Pat Gefre <pfg@sgi.com>, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix hotplug
In-Reply-To: <20040223210448.GA22598@kroah.com>
Message-ID: <Pine.SGI.3.96.1040224131328.43293F-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Greg KH wrote:

+ On Mon, Feb 23, 2004 at 08:55:14AM -0600, Pat Gefre wrote:
+ > +#define SYSCTL_PCI_UNINITIALIZED	(SYSCTL_PCI_ERROR_BASE - 0)
+ > +    { SYSCTL_PCI_UNINITIALIZED, "module not initialized" },
+ 
+ What are you going to do with this large table of strings?  I see where
+ you copy them to somewhere, but don't see anything beyond that.
+ 
+ Are we missing a huge piece of the puzzle?

Greg,

They are used in sysctl_pci_error_lookup(), which is called
pcibr_slot_pwr(), which is the code to put a device on-line. It all
traces back to the slot_enable call that is made from the hot plug
driver (which is not included in this mod).

-- Pat

