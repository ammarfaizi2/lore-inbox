Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266501AbUGUOye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUGUOye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUGUOye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:54:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:22443 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266501AbUGUOyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:54:33 -0400
Subject: Re: reserve legacy io regions on powermac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>
In-Reply-To: <20040721091249.GA1336@suse.de>
References: <20040721091249.GA1336@suse.de>
Content-Type: text/plain
Message-Id: <1090421466.2002.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 10:51:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 05:12, Olaf Hering wrote:
> Anton pointed this out.
> 
> ppc32 can boot one single binary on prep, chrp and pmac boards.
> pmac has no legacy io, probing for PC style legacy hardware leads to a
> hard crash.
> Several patches exist to prevent serial, floppy, ps2, parport and other
> drivers from probing these io ports.
> I think the simplest fix for 2.6 is a request_region of the problematic
> areas.
> PCMCIA is still missing.
> I found that partport_pc.c pokes at varios ports, without claiming the
> ports first. Should this be fixed?
> smsc_check(), winbond_check(), winbond_check2()

Note that this is still all workarounds... Nothing prevents you (and some
people actually do that) to put a PCI card with legacy serial ports on it
inside a pmac....

Ben.


