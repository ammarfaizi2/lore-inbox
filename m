Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264674AbTFVQw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 12:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTFVQw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 12:52:57 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53937 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S264812AbTFVQwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 12:52:51 -0400
Date: Sun, 22 Jun 2003 12:05:31 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Adrian Bunk <bunk@fs.tum.de>, Ed Okerson <eokerson@quicknet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [patch] ixj.c: EXPORT_SYMBOL of static functions
In-Reply-To: <1056280986.2075.8.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306221159390.7664-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jun 2003, Alan Cox wrote:

> On Sul, 2003-06-22 at 02:02, Adrian Bunk wrote:
> > drivers/telephony/ixj.c EXPORT_SYMBOL's two static functions.
> > 
> > Does this make any sense or is the patch below OK?
> 
> It's meant to export them. An exported static function is visible to
> other modules.

The exported functions shouldn't normally be declared static though, 
because that means that they will not be available to other modules in the 
built-in case.

So most likely the correct fix is to remove the "static". However, 
ixj_register() still doesn't seem to be used anywhere at all, at least not 
by in-tree modules.

--Kai


