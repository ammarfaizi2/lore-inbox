Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVBTJ1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVBTJ1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 04:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVBTJ1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 04:27:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62991 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261733AbVBTJ1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 04:27:03 -0500
Date: Sun, 20 Feb 2005 09:26:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Message-ID: <20050220092659.A9509@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org
References: <20050220092208.GA12738@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050220092208.GA12738@hardeman.nu>; from david@2gen.com on Sun, Feb 20, 2005 at 10:22:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 10:22:09AM +0100, David Härdeman wrote:
> Steven Rostedt wrote:
> > I have a IBM Thinkpad G41 with a pentium4M with Hyperthreading.  I can't
> > get the PCMCIA working at all.  I've tried turning off hyperthreading,
> > I've tried with and without preempt, I've even added pci=noacpi. I've
> > added Len's ACPI patches, but nothing works.
> 
> 
> I see the same problem with an IBM Thinkpad G40, and only when there is 
> 1Gb of memory or more in the machine.

Check to see if your e820 map has a hole in it, and whether any of
your Cardbus bridge memory / region 0 resources appear in it.

If your e820 map contains a hole, I'd suspect another buggy bios.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
