Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSJALTy>; Tue, 1 Oct 2002 07:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJALTx>; Tue, 1 Oct 2002 07:19:53 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:28678 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S261568AbSJALTw>; Tue, 1 Oct 2002 07:19:52 -0400
Date: Tue, 1 Oct 2002 13:28:58 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: David McIlwraith <quack@bigpond.net.au>
cc: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
In-Reply-To: <08e001c2693b$8e64e8c0$41368490@archaic>
Message-ID: <Pine.LNX.4.21.0210011324110.485-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, David McIlwraith wrote:

> Semaphores may sleep - therefore, they cannot be used from a 'non-sleep'
> context.

Yes, sure. Sorry if I wasn't clear enough - the point is whether those
tty_driver write/write_room() calls are allowed to sleep or not. If yes,
the usbserial implementation is right and it is impossible to do further
writing directly from write_wakeup() callback (which would be really bad
IMHO) - if not, usbserial needs to avoid the down() somehow.

Martin

