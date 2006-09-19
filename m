Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWISRlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWISRlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWISRlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:41:10 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:4876 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1030387AbWISRlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:41:09 -0400
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection
	capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20060919090945.GE24271@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102033.462112306@localhost.localdomain>
	 <1158645471.2419.13.camel@localhost.localdomain>
	 <20060919090945.GE24271@miraclelinux.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 10:35:27 -0700
Message-Id: <1158687327.2509.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 17:09 +0800, Akinobu Mita wrote:
> On Mon, Sep 18, 2006 at 10:57:51PM -0700, Don Mullis wrote:
> > Push fault-injection entries earlier in the list, so that they appear
> > nested under DEBUG_KERNEL in menuconfig/xconfig.
> 
> Disabling the option Kernel debugging can hide all config options
> realated to fault-injection without this patch.
> 
> Do I misunderstand something?
> 

There's no problem with hiding per se, but rather with the indentation
level.  It's most natural for the user to have dependent options
indented under their "parent".  For an example, in "menuconfig" try
setting "Compile the kernel with frame unwind information";
notice that "Stack unwind support" appears immediately underneath
it, indented.  The indentation reminds the user why "Stack unwind
support" has appeared.

Note that several of the pre-existing, non-fault-injection options
under "Kernel debugging", are also broken in this way.

