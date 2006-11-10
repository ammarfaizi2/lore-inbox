Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966089AbWKJE2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966089AbWKJE2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 23:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966087AbWKJE2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 23:28:06 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:10396 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S966086AbWKJE2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 23:28:04 -0500
Date: Thu, 9 Nov 2006 21:28:03 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Keith Owens <kaos@sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port
Message-ID: <20061110042803.GU16952@parisc-linux.org>
References: <200609261354.30722.bjorn.helgaas@hp.com> <14134.1163132600@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14134.1163132600@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 03:23:20PM +1100, Keith Owens wrote:
> Bjron, could you try kdb-v4.4-2.6.19-rc5-{common,ia64}-2 on your
> problem system?  I changed kdb so it only uses the keyboard if at least
> one console matches the pattern /^tty[0-9]*$/.  IOW, if the user
> specifies an i8042 style console on the command line (or uses the
> default with CONFIG_VT=y) then kdb will attempt to use that keyboard.
> Otherwise kdb ignores a VT style console, even when the kernel is
> compiled with CONFIG_VT=y.

If I'm using an HP Integrity system with a USB keyboard, won't I still
have a console that matches ^tty[0-9]*$ ?
