Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVBTPs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVBTPs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 10:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVBTPs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 10:48:29 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:36531 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261853AbVBTPs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 10:48:27 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: puneet_kaushik@persistent.co.in
Subject: Re: Needed faster implementation of do_gettimeofday()
Date: Sun, 20 Feb 2005 10:48:00 -0500
User-Agent: KMail/1.7.92
Cc: linux-kernel@vger.kernel.org
References: <34373.203.199.147.2.1108897097.squirrel@webmail.persistent.co.in>
In-Reply-To: <34373.203.199.147.2.1108897097.squirrel@webmail.persistent.co.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502201048.01424.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 February 2005 05:58 am, puneet_kaushik@persistent.co.in wrote:
> 985913    8.6083  vmlinux                  mark_offset_tsc
> 584473    5.1032  libc-2.3.2.so            getc

What makes you think mark_offset_tsc is slow? Do you have any comparative 
numbers?  It might just be that the workload you are throwing at it justifies 
it. (For e.g. if your workload does a zillion system calls, system_call will 
show up as a hot spot in oprofile - doesn't necessarily mean it is slow - 
it's just overused.) Can you post the relevant code?

Parag
