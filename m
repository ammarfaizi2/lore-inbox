Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267924AbUG2PG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUG2PG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUG2PGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:06:33 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:37760 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S265212AbUG2ORs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:17:48 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: fixing usb suspend/resuming
Date: Thu, 29 Jul 2004 07:16:21 -0700
User-Agent: KMail/1.6.2
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <200407202205.37763.david-b@pacbell.net> <20040729083543.GG21889@openzaurus.ucw.cz>
In-Reply-To: <20040729083543.GG21889@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407290716.21238.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 July 2004 01:35, Pavel Machek wrote:

> > See http://bugme.osdl.org/show_bug.cgi?id=2886 ... basically
> > it looks like this problem would show up with any of a dozen
> > or so different drivers, few of which are widely used on systems
> > that use suspend/resume much (laptops!).
> 
> Ben H. has some ideas how to fix this. Anyway, storing S-state or D-state in
> integer is bad because someone will get it wrong.

Right, there seems to be agreement that passing an ACPI S-state u32 down to
drivers expecting non-ACPI D-state u32 is a bad idea..  Drivers should see
the right bus-specific D-states ... see

http://www.mail-archive.com/linux-usb-devel%40lists.sourceforge.net/msg26528.html

which touches on some of the issues with what he explained to me.

- Dave.  
 
