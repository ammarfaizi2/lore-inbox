Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVHAAG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVHAAG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVHAAG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:06:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262167AbVHAAG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:06:57 -0400
Date: Sun, 31 Jul 2005 20:06:04 -0400
From: Dave Jones <davej@redhat.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: "Brown, Len" <len.brown@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050801000604.GB28907@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andreas Steinmetz <ast@domdv.de>,
	"Brown, Len" <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Ritz <daniel.ritz@gmx.ch>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com> <20050731222751.GA28907@redhat.com> <42ED6610.9040202@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ED6610.9040202@domdv.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 02:00:16AM +0200, Andreas Steinmetz wrote:

 > gringo:~ # fdisk -l /dev/hda
 > 
 > Disk /dev/hda: 80.0 GB, 80026361856 bytes
 > 255 heads, 63 sectors/track, 9729 cylinders
 > Units = cylinders of 16065 * 512 = 8225280 bytes
 > 
 >    Device Boot   Start      End      Blocks   Id  System
 > /dev/hda1            1      244     1959898+  83  Linux
 > /dev/hda2          245      488     1959930   82  Linux swap / Solaris
 > /dev/hda3          489      732     1959930   82  Linux swap / Solaris
 > /dev/hda4          733     9729    72268402+   5  Extended
 > /dev/hda5          733      976     1959898+  82  Linux swap / Solaris
 > /dev/hda6          977     9729    70308441   88  Linux plaintext (*)
 > 
 > (*) dm-crypt :-)

Your swap partitions are outside of your lv's.

		Dave

