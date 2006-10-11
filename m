Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWJKHEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWJKHEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWJKHEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:04:22 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:14555 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161000AbWJKHEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:04:20 -0400
Date: Wed, 11 Oct 2006 08:04:12 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Yu Luming <luming.yu@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061011070412.GA6128@srcf.ucam.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com> <200610102232.46627.luming.yu@gmail.com> <20061010212615.GB31972@srcf.ucam.org> <1160549944.3000.347.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160549944.3000.347.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 08:59:04AM +0200, Arjan van de Ven wrote:

> it'd also be nice if the linux-ready firmware developer kit had a test
> for this, so that we can offer 1) a way to test this to the bios guys
> and 2) encourage adding/note the lack easily

Sure. Reading /proc/acpi/video/*/*/info should tell you whether a device 
is an LCD or not. The brightness file should then contain a list of 
available brightnesses, and writing one into there should change the 
screen value. There's a patch somewhere that ports this to the 
/sys/class/backlight infrastructure, but I don't think it's applied yet.

I'd write a test up for you, but I don't actually seem to have any 
hardware that implements this properly. Tch.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
