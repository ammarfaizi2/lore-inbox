Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUAARae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUAARae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:30:34 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:11413 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264522AbUAARac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:30:32 -0500
Date: Thu, 1 Jan 2004 12:30:28 -0500
To: linux-kernel@vger.kernel.org, zydas@tiscali.co.uk
Subject: Re: kernel 2.6.0 making modules problems
Message-ID: <20040101173028.GA1282@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Season's Greetings.

`make modules` should be run as a user; only `make modules_install` need
be run as root.

To fix the problem, I would try adding '#include <asm/termbits.h>'
to the top of 'drivers/usb/serial/whiteheat.c'.  Probably this has never
before been compiled with your hardware configuration.

Justin
