Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265557AbSJXRIv>; Thu, 24 Oct 2002 13:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265558AbSJXRIu>; Thu, 24 Oct 2002 13:08:50 -0400
Received: from fmr01.intel.com ([192.55.52.18]:44772 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265557AbSJXRIt>;
	Thu, 24 Oct 2002 13:08:49 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF76@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'David C. Hansen'" <haveblue@us.ibm.com>, ebuddington@wesleyan.edu
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.44-ac2: stack overflow in acpi_initialize_objects
Date: Thu, 24 Oct 2002 10:14:58 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David C. Hansen [mailto:haveblue@us.ibm.com] 
> On Thu, 2002-10-24 at 07:20, Eric Buddington wrote:
> > 2.5.44-ac2 compiled for Athlon with gcc-3.2 fails to boot with a
> > really exciting stack overflow that dumps hordes of stack 
> trace on the
> > screen. I'm too lazy to write it all down, but the last line before
> > 'init' refers to acpi_initialize_objects.
> > 
> > I can write down more of it if needed.
> 
> Does it panic, or just print out a lot of the traces?  

The ACPI-related call path to acpi_initialize_objects is only 3 deep:

acpi_init
acpi_bus_init
acpi_initialize_objects

...none of which have big variables on the stack.

Need more info...

-- Andy
