Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbTDCReu 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261427AbTDCReu 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:34:50 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:60339 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261412AbTDCRer 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:34:47 -0500
Date: Thu, 3 Apr 2003 18:45:26 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Shawn Starr <shawn.starr@datawire.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acpi spinlock breakage
Message-ID: <20030403174521.GA25720@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Shawn Starr <shawn.starr@datawire.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304031226.12300.shawn.starr@datawire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304031226.12300.shawn.starr@datawire.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:26:12PM -0500, Shawn Starr wrote:
 > Confirmed :-(
 > 
 > Trying to find out what broke, but none of those members are listed even 
 > inside osl.c (perhaps a header down the line).

They're members of the spinlock_t struct.
That acpi_handle needs to be a spinlock_t *

		Dave

