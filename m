Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVACNBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVACNBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVACNBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:01:10 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:10695 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261434AbVACNBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:01:08 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Altix hang on boot with 2.6.8+ 
In-reply-to: Your message of "Mon, 03 Jan 2005 13:52:00 BST."
             <20050103125200.GK26303@fi.muni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Jan 2005 00:00:49 +1100
Message-ID: <16872.1104757249@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005 13:52:00 +0100, 
Jan Kasprzak <kas@fi.muni.cz> wrote:
>I cannot boot a 2.6.8 or 2.6.10 kernel on my SGI Altix - it hangs during
>boot after printing this:
>
>[...]
>CPU 0: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
>Console: colour dummy device 80x25

The Altix console changed from ttyS0 to ttySG0 around 2.6.8.  You need to
  mknod ttySG0 c 204 40
and change elilo.conf to use console=ttySG0 for the newer kernels.  You
also need to change /etc/inittab from ttyS0 to ttySG0.

Most Altix systems running 2.6 have both ttyS0 and ttySG0 defined in
/dev and have two lines in /etc/inittab to allow switching between old
and new kernels.

