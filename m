Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTD3WaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTD3WaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:30:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:46220 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S262465AbTD3WaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:30:22 -0400
Date: Wed, 30 Apr 2003 17:42:34 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: rusty@rustcorp.com.au, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Loading a module multtiple times
In-Reply-To: <20030430140557.12e13f1a.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0304301740370.3902-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, Randy.Dunlap wrote:

> To get a large number of network interfaces, Christian (below)
> told me to copy driver/net/dummy.o to several different file names
> and then insmod them.  It seems to have worked for him, and it works
> that way in 2.4.recent, but it's not working for me.  See error
> messages below.
> 
> Which way is expected behavior?
> What should be the expected behavior?

This failure is expected behavior, AFAICT. The module.ko has the module 
name embedded and thus duplicate insertion will be recognized even when 
the .ko file has been renamed.

To allow insertion of a module under a new name, you have to give
module-init-tools some new option (which I can't remember right now).

--Kai


