Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVECDGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVECDGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 23:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVECDGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 23:06:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:40897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261330AbVECDGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 23:06:14 -0400
Date: Mon, 2 May 2005 20:05:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 OOPS  in vanilla source (once more)
Message-Id: <20050502200545.266b4e55.akpm@osdl.org>
In-Reply-To: <42763388.1030008@gmail.com>
References: <42763388.1030008@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mateusz Berezecki <mateuszb@gmail.com> wrote:
>
> i send it once more....
> 
>  May  2 12:56:31 localhost kernel: Unable to handle kernel NULL pointer 
>  dereference at virtual address 00000000

The trace is unusable.  Please do

	dmesg -s 1000000 > /tmp/foo

and see if there's anything useful in /tmp/foo.

Also, please edit /etc/init.d/syslog so that it starts syslogd with the
`-x' option.  Heaven knows when we'll be rid of the current junk.

