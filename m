Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263569AbTDIP5X (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTDIP5W (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:57:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263569AbTDIP5V (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 11:57:21 -0400
Date: Wed, 9 Apr 2003 09:08:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what means duplicate "config" entries in Kconfig file?
Message-Id: <20030409090830.22f58832.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0304090826470.25330-100000@dell>
References: <Pine.LNX.4.44.0304090826470.25330-100000@dell>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003 08:30:34 -0400 (EDT) "Robert P. J. Day" <rpjday@mindspring.com> wrote:

|   [i just tried to email the Kconfig maintainer, but sendmail
| suggested that that mail might not have gotten through, so i'll
| toss this out here.]
| 
|   in my quest to clean up even more kernel config menus,
| i ran across the following oddity in arch/i386/Kconfig:
| 
| -----
| 
| config MCA
| 	bool "MCA support"
| 	depends on !(X86_VISWS || X86_VOYAGER)
| 	help
| 	  MicroChannel Architecture is found in some IBM PS/2 machines and
| 	  laptops.  It is a bus system similar to PCI or ISA. See
| 	  <file:Documentation/mca.txt> (and especially the web page given
| 	  there) before attempting to build an MCA bus kernel.
| 
| config MCA
| 	depends on X86_VOYAGER
| 	default y if X86_VOYAGER
| 
| source "drivers/mca/Kconfig"
| 
| -----
| 
|   i'm not sure what it means to have two config entries with 
| identical symbols.  can someone clarify this?  i'm just confused
| (which should not come as a surprise at this point).


This should be OK.  The "depends" clauses are different,
so in the second case, MCA defaults to set/enabled for X86_VOYAGER
(forced, not a user option),
and in the first case, MCA is a user config option.


--
~Randy
