Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTFVM6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTFVM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 08:58:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4874 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264682AbTFVM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 08:58:43 -0400
Date: Sun, 22 Jun 2003 14:12:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: hugang <hugang@soulinfo.com>, dahinds@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Pcmcia GPRS cards not works in linux.
Message-ID: <20030622141238.A16537@flint.arm.linux.org.uk>
Mail-Followup-To: David Hinds <dhinds@sonic.net>,
	hugang <hugang@soulinfo.com>, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030615104322.496279e1.hugang@soulinfo.com> <20030615103456.B27533@flint.arm.linux.org.uk> <20030615204019.C10594@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615204019.C10594@sonic.net>; from dhinds@sonic.net on Sun, Jun 15, 2003 at 08:40:19PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 08:40:19PM -0700, David Hinds wrote:
> The pcmcia-cs package and the 2.4 kernel PCMCIA subsystem already do
> the right thing.  The 2.5 8250_cs driver had been sufficiently altered
> (reindented, line breaks moved around, etc) that applying patches is
> quite inconvenient and I had not gotten around to going through line
> by line and figuring out what changes needed to be applied.

I've just updated 8250_cs.c with the changes found in pcmcia-cs 3.1.32
and 3.1.34, and updated the revision IDs to match that.  This includes
both the changes to ignore the Vcc in the CIS (and use the detected
voltages) and the "buggy uart" business.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

