Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275316AbTHMSlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275341AbTHMSlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:41:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38411 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275316AbTHMSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:39:00 -0400
Date: Wed, 13 Aug 2003 19:38:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813193855.E20676@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
	davej@redhat.com, willy@debian.org, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3A82C3.5060006@pobox.com>; from jgarzik@pobox.com on Wed, Aug 13, 2003 at 02:26:11PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 02:26:11PM -0400, Jeff Garzik wrote:
> Again, my philosophy:  put the data in its most natural form.  In 
> CS-speak, domain-specific languages.  So, just figure out what you want 
> the data files to look like, and I'll volunteer to write the parser for it.

But what's the point of the extra complexity?  People already put
references to other structures in the driver_data element, and
enums, so completely splitting the device IDs from the module
source is not going to be practical.

Are you thinking of a parser which outputs C code for the module to
include?  That might be made to work, but it doesn't sound as elegant
as the solution being described previously in this thread.

"Make the easy things easy (PCI_DEVICE(vendor,device)) and make the
not so easy things possible (the long form)"

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

