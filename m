Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTKLVas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTKLVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 16:30:48 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:131 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261614AbTKLVaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 16:30:46 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Why can't I shut scsi device support off in -test9?
Date: Wed, 12 Nov 2003 15:27:23 -0600
User-Agent: KMail/1.5
Cc: mzyngier@freesurf.fr, linux-kernel@vger.kernel.org
References: <200311120046.04348.rob@landley.net> <200311120203.51599.rob@landley.net> <20031112085804.0cfbaddf.rddunlap@osdl.org>
In-Reply-To: <20031112085804.0cfbaddf.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311121527.23123.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 November 2003 10:58, Randy.Dunlap wrote:
> On Wed, 12 Nov 2003 02:03:51 -0600 Rob Landley <rob@landley.net> wrote:
> | On Wednesday 12 November 2003 01:34, Marc Zyngier wrote:
> | > >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
> | >
> | > Rob> I tried switching SCSI support off by hand (editing .config) and
> | > Rob> it still showed up in the menu.  (Maybe turned back on by a
> | > Rob> dependency, but on what?)
> | >
> | > Care to submit this .config ?
>
> I also have no trouble disabling CONFIG_SCSI with this .config file,
> using any of 'make menuconfig|xconfig|oldconfig' ($EDITOR + oldconfig).
>
> on 2.6.0-test9 plain
>
> A quick grep of all Kconfig files finds only USB_STORAGE that
> does a "select SCSI" when it (USB_STORAGE) is enabled.

Huh, so IDE scsi emulation doesn't?  (Not that I use it.  I want SCSI _off_.)

Hmmm...  I just extracted a fresh tarball and tried again and had the same 
problem.  Possibly I'm looking in the wrong place?  "Device drivers"->"SCSI 
Devices", top of the menu the option is "---" instead of selectable.  Seems 
an odd place to put the SCSI bus, but I can't find it it any of the menus 
above that (and I just spent another 5 minutes looking).

It's too late in the development cycle to complain about the menu layout, but 
as soon as 2.7 opens...  (Okay, I'll get lost in the noise, but still...)

Rob

Don't worry, if I get really bored, I'll start sticking printfs into kconfig.  
In the mean time, I can pipe .config through "grep -v SCSI" for my own 
purposes...
