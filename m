Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbVCQPKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbVCQPKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbVCQPKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:10:48 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:28586 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S263088AbVCQPKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:10:20 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Nate Lawson <nate@root.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <423518E7.3030300@root.org>
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org>
Date: Thu, 17 Mar 2005 15:10:21 +0000
Message-Id: <1111072221.8136.171.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] IDE failure on ACPI resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 20:53 -0800, Nate Lawson wrote:

> Sounds like PCI not being completely restored.  We had to work around 
> some weird ATA issues in FreeBSD with the status register being invalid 
> for quite a while after resume.  A retry loop was the solution.

FreeBSD seems to fail in the same way on the same hardware,
unfortunately. I'm leaning towards suspecting that we need to be doing
something with the contents of the _GTF method, but by the looks of that
that requires us to be able to work out which methods correspond to
which hardware. Is anyone working on implementing this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

