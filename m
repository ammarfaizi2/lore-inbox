Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUFQRcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUFQRcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUFQRcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:32:51 -0400
Received: from [217.73.129.129] ([217.73.129.129]:202 "EHLO car.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261206AbUFQRb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:31:27 -0400
Date: Thu, 17 Jun 2004 20:31:10 +0300
Message-Id: <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH] remove EXPORT_SYMBOL(kallsyms_lookup)
To: greg@kroah.com, linux-kernel@vger.kernel.org
References: <20040617162927.GA12498@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Greg KH <greg@kroah.com> wrote:
GK> Distros have started to ship kernels with this patch, as it seems that
GK> some unnamed binary module authors are already abusing this function (as
GK> well as some open source modules, like the openib code.)  I could not
GK> find any valid reason why this symbol should be exported, so here's a

What if some extra carefully written code detects some (non fatal) problem in
itself and decides to dump a decoded backtrace to some internal log buffer,
user will find this later and will send a bugreport to developers?
(yes, there are problems with simply doing dump_stack()).
Or perhaps we need dump_stack version that will print the dump into a
supplied buffer then?

Bye,
    Oleg
