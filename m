Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVC1LBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVC1LBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVC1LBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:01:20 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:32198 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261489AbVC1LBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:01:18 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: David Dyck <david.dyck@fluke.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: upgrading modutils may have fixed: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL) 
In-reply-to: Your message of "Mon, 28 Mar 2005 06:20:01 +0200."
             <20050328042001.GR30052@alpha.home.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Mar 2005 21:00:59 +1000
Message-ID: <6507.1112007659@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 06:20:01 +0200, 
Willy Tarreau <willy@w.ods.org> wrote:
>I believe it's because of genksyms during the build process, I had the
>exact same problem a few weeks ago on a machine with old modutils. So
>you should have cleaned everything and rebuilt from scratch after
>installing your new modutils. BTW, the required modutils in
>Documentation/Changes is still marked as 2.4.10, I hope it is still
>enough.

You need modutils >= 2.4.14 to use the combination of
CONFIG_MODVERSIONS with EXPORT_SYMBOL_GPL() on 2.4 kernels.

