Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUANTVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUANTTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:19:44 -0500
Received: from adsl-ull-213-87.42-151.net24.it ([151.42.87.213]:43780 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263370AbUANTSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:18:21 -0500
Date: Wed, 14 Jan 2004 20:18:18 +0100
From: Daniele Venzano <webvenza@libero.it>
To: m.andreolini@tiscali.it
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
Message-ID: <20040114191818.GG13899@picchio.gall.it>
Mail-Followup-To: m.andreolini@tiscali.it,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040114165056.GD13899@picchio.gall.it> <3FE5F1110002D60F@mail-4.tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE5F1110002D60F@mail-4.tiscali.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.24-xfs-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 06:59:36PM +0100, m.andreolini@tiscali.it wrote:
> I can't even 'tcpdump eth0' since the eth0 interface is not brought up correctly
> on resume:
> ifconfig yields only the loopback entry.

If the card isn't even brought up it means that you're lacking power
management completely for that device.

I'm using pmdisk, perhaps swsusp is using different calls to device drivers,
and no one has ever written them for sis900.
I searched documentation on swsusp interface, but found nothing,
as a matter of fact I assumed that what's in Documentation/power would
apply to both pmdisk and swsusp, since they're similar implementations.

Check that the patch at:
http://teg.homeunix.org/kernel_patches.html is in your tree.

If you have time try to match my configuration (2.6.1, pmdisk and sis900
compiled in) and see if that way it works.

Bye

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

