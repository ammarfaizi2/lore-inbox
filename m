Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVDKUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVDKUfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVDKUe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:34:58 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:57554 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261930AbVDKUcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:32:11 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050411201741.73077.qmail@web88002.mail.re2.yahoo.com>
References: <20050411201741.73077.qmail@web88002.mail.re2.yahoo.com>
Date: Mon, 11 Apr 2005 21:32:34 +0100
Message-Id: <1113251554.10110.60.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay
	light in S3 mode stays on
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 16:17 -0400, Shawn Starr wrote:
> Sure, I suppose you can, but most suspend tools just
> echo stuff to /sys (or still /proc/acpi/sleep) which
> makes it harder to script it. Besides, when a laptop
> goes into suspend to RAM there should be no extra
> power   on except a Moon or some other icon.

Most suspend tools are depressingly stupid. That's not a good reason to
push functionality into the kernel. The vast majority of hardware won't
work with that approach at the moment.

> That said, the ACPI thinkpad extras was designed to do
> all of this so why shouldn't the driver do S3 suspend
> if it hooks into it already?

Because, well, strictly it wasn't. The LED control functionality in the
IBM-acpi code exists because it exposes methods that are used by the
BIOS in normal usage. It gives some degree of extra flexibility -
there's no point in removing that for the sake of having one fewer line
of shell in a suspend script. I might want the LEDs to be in different
states depending on what triggered the suspend.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

