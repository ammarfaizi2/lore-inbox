Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUK1SO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUK1SO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbUK1SO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:14:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:2194 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261543AbUK1SOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:14:55 -0500
Subject: Re: [2.6 PATCH] visor: Make URB limit error more visible
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Luethi <rl@hellgate.ch>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125161619.GD18567@k3.hellgate.ch>
References: <20041116154943.GA13874@k3.hellgate.ch>
	 <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch>
	 <20041124232527.GB4394@kroah.com>  <20041125161619.GD18567@k3.hellgate.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101661884.16787.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:11:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-25 at 16:16, Roger Luethi wrote:
> There is only one call to dev_dbg in all of visor.c, the rest is dbg or
> dev_err. It already bit us once when warnings didn't turn up in a debug
> log. I would argue that a flood of those warnings will warrant report
> and inspection anyway (broken app, broken driver, or lame DoS attempt),
> so I replaced the dev_dbg with dev_err.
> 
> Signed-off-by: Roger Luethi <rl@hellgate.ch>

Since it is trivially user caused should it not be rate limited or it
becomes a DoS of its own to the syslog

