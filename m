Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTDUUCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTDUUCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:02:48 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21346 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261821AbTDUUCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:02:48 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200304212014.h3LKEiE00854@devserv.devel.redhat.com>
Subject: Re: [PATCH] DAC960 open with O_NONBLOCK
To: dmo@osdl.org (Dave Olien)
Date: Mon, 21 Apr 2003 16:14:44 -0400 (EDT)
Cc: hch@infradead.org (Christoph Hellwig), marcelo@conectiva.com.br,
       alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030421190111.GA27126@osdl.org> from "Dave Olien" at Ebr 21, 2003 12:01:11 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> John Kamp has run across a libhd applcation from Suse that hit this bug.
> It's some kind of hardware detection application.  It opens devices with
> O_NONBLOCK.  But, it doesn't in fact use the DAC960 pass-through commands.

It should be checking major/minor first - rightfully or wrongly (I'd 
favour wrongly) open has side effects on multiple devices.

> The difficulty is that the Mylex application is available only in binary
> form.  Mylex is very secretive about its controller commands.
> It would be nice to be able to create a library that an application
> could call to perform high-level operations, and the library would
> construct the pass-through commands and pass them to the driver.
> Then, anyone could write their own GUI.

Or someone could just stick a command dumper in the driver. Thats how I
wrote ps and a few other utils for my aacraid 8)
