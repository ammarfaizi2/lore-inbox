Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUHPOFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUHPOFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHPOFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:05:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:65507 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267626AbUHPOFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:05:42 -0400
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: John Wendel <jwendel10@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040816143817.0de30197.Ballarin.Marc@gmx.de>
References: <411FD919.9030702@comcast.net>
	 <20040816143817.0de30197.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092661385.20528.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 14:03:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 13:38, Marc Ballarin wrote:
> Due to the newly added command filtering, you now need to run cdrecord as
> root. Since cdrecord will drop root privileges before accessing the drive,
> setuid root won't help

cdrecord should be fine. k3b is issuing something not on the filter
list.

> This patch restores the behaviour of previous kernels, security issues included:

Like allowing any user to erase your drive firmware. What you could do
which is much more useful is printk the command byte that gets refused
and see if you can pin down what commands are being blocked that
are needed by K3B 

Alan

