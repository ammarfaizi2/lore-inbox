Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272593AbTG1AUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272466AbTG1AG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:06:28 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51698 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272379AbTG0WyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:54:18 -0400
Date: Sun, 27 Jul 2003 15:26:20 -0600 (MDT)
Message-Id: <20030727.152620.127108646.imp@bsdimp.com>
To: willy@debian.org
Cc: aebr@win.tue.nl, vandrove@vc.cvut.cz, jvb@prairienet.org,
       bcollins@debian.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, gan@planetlaz.com
Subject: Re: [ACPI] Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20030727210203.GU1485@parcelfarce.linux.theplanet.co.uk>
References: <20030725161510.GA31565@vana.vc.cvut.cz>
	<20030725165709.GA670@win.tue.nl>
	<20030727210203.GU1485@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mew version 2.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message: <20030727210203.GU1485@parcelfarce.linux.theplanet.co.uk>
            Matthew Wilcox <willy@debian.org> writes:
: On Fri, Jul 25, 2003 at 06:57:09PM +0200, Andries Brouwer wrote:
: > strlcpy is for strings, not for character arrays.
: > The *BSD version accesses the source past the size-1 characters
: > that are copied: 
: > 	while (*s++)
: > 		;
: > Thus, replacing strncpy (used to copy character arrays, possibly
: > not 0-terminated) by strlcpy is wrong.

Ah, that's to get the silly return value correct :-(.

Warner
