Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269454AbUJFUHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269454AbUJFUHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUJFUHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:07:32 -0400
Received: from ns1.maildns.com ([64.215.178.100]:29889 "HELO maildns.com")
	by vger.kernel.org with SMTP id S269455AbUJFUGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:06:43 -0400
Subject: Re: PROBLEM: shutdown fails with 2.6.9-rc3
From: Charles Johnston <charles@infoplatter.com>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097090983.10141.3.camel@athena.fprintf.net>
References: <1097090983.10141.3.camel@athena.fprintf.net>
Content-Type: text/plain
Message-Id: <1097093201.3008.2.camel@mercury>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 14:06:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 13:29, Daniel Gryniewicz wrote:
> Hi, all.
> 
> I just upgraded to 2.6.9-rc3 from a 2.6.8.1 based kernel, and my laptop
> is no longer powering off.  Sometimes, the screen powers off, sometimes
> it sits there saying "Power Down",  but in either case, the power LED is
> still lit, and a hard power-off is necessary.  This did not happen with
> 2.6.8.1.  I tried booting with acpi=off (as there was a report of
> shutdown weirdness due to acpi on 2.6.9-rc1), but that did not help.
> 
> I have a Dell Inspiron 8600 laptop, with a Pentium-M 1500, and Centrino
> chipset.  Attached is lscpi, cpuinfo, /proc/modules, and config for the
> 2.6.9-rc3 kernel that fails.
> 
> Linux version 2.6.9-rc3 (dang@athena) (gcc version 3.4.2 (Gentoo Linux
> 3.4.2-r2, ssp-3.4.1-1, pie-8.7.6.5)) #1 Wed Oct 6 15:02:35 EDT 2004
> 
> Daniel

I have the same machine and experienced the same problem starting with
2.6.9-rc1.

The solution is to disable APIC and IO-APIC support.  The reason why it
now has problems is the black-list with the Inspiron on it was removed.


Charles

