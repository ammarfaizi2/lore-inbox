Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTE2U13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTE2U13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:27:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262636AbTE2U12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:27:28 -0400
Date: Thu, 29 May 2003 21:40:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mark Haverkamp <markh@osdl.org>
Cc: Pat Mochel <mochel@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci bridge class code
Message-ID: <20030529214044.B30661@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Haverkamp <markh@osdl.org>,
	Pat Mochel <mochel@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1054239461.28608.74.camel@markh1.pdx.osdl.net>; from markh@osdl.org on Thu, May 29, 2003 at 01:17:42PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 01:17:42PM -0700, Mark Haverkamp wrote:
> This adds pci-pci bridge driver model class code.  Entries appear in 
> /sys/class/pci_bridge.

Hmm.  Ok.

How do you propose to handle the following case:

Mobility Electronics supply a Cardbus to PCI bridged "docking station"
which has a PCI-PCI bridge on with vendor stuff above 0x40.  It appears
as a standard PCI-PCI bridge; the only specific identifying information
are the device and vendor IDs.  How can I guarantee that a driver I
write for this device will be picked up in preference to your driver.

(Given that your driver would probably be always loaded, and my driver
could well be a loadable module.)

I'm not saying that I will need to do this, but this is something which
needs to be carefully thought about if we're going to provide a generic
driver.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

