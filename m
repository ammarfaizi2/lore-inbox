Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWBBPZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWBBPZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWBBPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:25:35 -0500
Received: from smtp.thphy.uni-duesseldorf.de ([134.99.64.9]:50621 "EHLO
	ramses.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id S932079AbWBBPZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:25:33 -0500
Date: Thu, 2 Feb 2006 16:25:31 +0100
From: Ansgar Esztermann <ansgar@thphy.uni-duesseldorf.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFT] sky2: pci express error fix
Message-ID: <20060202152531.GE8319@subraumtor.thphy.uni-duesseldorf.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200601190930.k0J9US4P009504@typhaon.pacific.net.au> <20060124220533.5fade501@localhost.localdomain> <drasb9$5jj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <drasb9$5jj$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

> For all those people suffering with pci express errors
> on the sky2 driver.  The problem is the PCI subsystem sometimes
> won't let the sky2 driver write to PCI express registers. It depends
> on the phase of the moon (actually ACPI) and number of devices.
> 
> Anyway, this should fix it. Please tell me if it solves it for you.

I've applied your patch to an -mm4 soure tree, and the error messages
did stop. Thanks!

BTW, I think there is a typo in this line:
+ sky2_write32(hw, PCI_CI(PEX_UNC_ERR_STAT), 0xffffffffUL);
(it should be PCI_C, not PCI_CI).

A.
-- 
Ansgar Esztermann
Researcher & Sysadmin
http://www2.thphy.uni-duesseldorf.de/~ansgar
