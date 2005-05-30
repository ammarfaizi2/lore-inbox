Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVE3XHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVE3XHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVE3XHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:07:46 -0400
Received: from mail1.kontent.de ([81.88.34.36]:30876 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261814AbVE3XHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:07:09 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [BUG] oops while completing async USB via usbdevio
Date: Tue, 31 May 2005 01:07:03 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <20050530212641.GE25536@sunbeam.de.gnumonks.org>
In-Reply-To: <20050530212641.GE25536@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505310107.03747.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and it prints "p->sighand == NULL" every time I exit a program while
> using the usbdevio based driver.
> 
> consequently, the following patch 'fixed' the problem.  Please do not
> consider this as a real fix, since there's certainly still a race
> condition left.   Please use it as a hint to correctly fix the problem.

It would be cleaner to terminate all URBs a task has submitted when the
task terminates.

	Regards
		Oliver

