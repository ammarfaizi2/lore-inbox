Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUD0XdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUD0XdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbUD0Xb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:31:59 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:1173 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264444AbUD0XbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:31:01 -0400
Date: Wed, 28 Apr 2004 01:30:58 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Tim Hockin <thockin@hockin.org>
cc: Michael Poole <mdpoole@troilus.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <20040427230545.GA15747@hockin.org>
Message-ID: <Pine.LNX.4.44.0404280114580.15111-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Tim Hockin wrote:

> On Wed, Apr 28, 2004 at 12:59:23AM +0200, Robert M. Stockmann wrote:
> > look i have made complaints about gcc-3.x some time ago, on the gcc
> > mailinglist. Also there they put my opinions aside, with arguments
> > like any powerfull feature can be used in a bad and in a good way. 
> > The powerfull feature here is the C99 coding style, which allows for 
> > unnamed and anonymous structures and unions. Don't kill our C99 cause it
> > can do bad things. Of course not.
> 
> > If every major hardware vendor (like e.g. Adaptec, LSI Logic) will change
> > its policy, to implement its drivers as semi- binary only kernel modules, like
> > Promise did with its FastTrak line of controllers, like in the example above,
> > the Open Source lable of the linux kernel can be placed into the computer
> > museum. Isn't that exactly what a certain Redmond software company wants
> > to achieve?
> 
> What the hell do these two paragraphs have to do with each other?
> 

C99 coding style, more specific the use of unnamed and anonymous structures
and unions, allows the kernel programmer to interface, read glue, binary only
driver modules to interface with any linux kernel source tree.

Using this feature one can link and merge any binary only module.o to any
kernel source version of your choice. In this way, typically, a OEM vendor,
releases a semi open-source link kit, which also contains binary only
components, once. This semi open source link-kit will then work with any 2.6.x
or 2.4.2x kernel source tree.

The needed header files, which need to be read by the gcc compiler, contain
unnamed and annonymizes structures and unions. In the worst case scenario,
only the name of used variables are given and no info about variable type or
size are inside these headers files. gcc-2.95.3 fails to succesfully link these
semi open-source link-kits, and gcc-3.x (which supports C99) of course has
no problems doing this.

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

