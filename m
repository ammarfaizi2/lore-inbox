Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266614AbUGUUIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUGUUIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUGUUIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:08:30 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:16480 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266614AbUGUUI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:08:28 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: reserve legacy io regions on powermac
Date: Wed, 21 Jul 2004 16:07:11 -0400
User-Agent: KMail/1.6.2
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>
References: <20040721091249.GA1336@suse.de> <1090421466.2002.24.camel@gaston>
In-Reply-To: <1090421466.2002.24.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407211607.11915.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 21, 2004 10:51 am, Benjamin Herrenschmidt wrote:
> On Wed, 2004-07-21 at 05:12, Olaf Hering wrote:
> > Anton pointed this out.
> >
> > ppc32 can boot one single binary on prep, chrp and pmac boards.
> > pmac has no legacy io, probing for PC style legacy hardware leads to a
> > hard crash.
> > Several patches exist to prevent serial, floppy, ps2, parport and other
> > drivers from probing these io ports.
> > I think the simplest fix for 2.6 is a request_region of the problematic
> > areas.
> > PCMCIA is still missing.
> > I found that partport_pc.c pokes at varios ports, without claiming the
> > ports first. Should this be fixed?
> > smsc_check(), winbond_check(), winbond_check2()
>
> Note that this is still all workarounds... Nothing prevents you (and some
> people actually do that) to put a PCI card with legacy serial ports on it
> inside a pmac....

Can you actually support this?  Will it work?

As for the patch, why not just reserve the first 64k of address space 
altogether instead of the individual ports?

Jesse
