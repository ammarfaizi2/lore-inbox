Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVAFQod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVAFQod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVAFQod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:44:33 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:51402 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S262881AbVAFQoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:44:12 -0500
Subject: Re: 2.6.10-mm1
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF4C49B1DD.0FAC66D2-ON86256F81.0059D64B@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Thu, 6 Jan 2005 10:32:31 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/06/2005 10:43:23 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After booting with 2.6.10-mm1, I get the following message on the serial
console (last message seen):

PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)

For reference, lspci shows that device is
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)

I notice there is a relatively recent patch to add this message.
  http://article.gmane.org/gmane.linux.kernel/263974

However, my .config includes

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

which should disable all power management related processing.

[1] Should the code generating the warning be active without CONFIG_PM
being set?

[2] Can you explain why the message is generated (why not silently ignore
the older hardware) or is there something in an init script (I am using
Fedora Core 2) that [incorrectly] assumes power management is available to
cause the message to be printed?

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

