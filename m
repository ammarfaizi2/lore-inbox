Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbUBQGIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUBQGIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:08:42 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:34232 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266043AbUBQGIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:08:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PSX support in input/joystick/gamecon.c
Date: Tue, 17 Feb 2004 01:08:06 -0500
User-Agent: KMail/1.6
Cc: Peter Nelson <pnelson@andrew.cmu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>
References: <20040215222107.720832C2CC@lists.samba.org> <4031AB8D.1040209@andrew.cmu.edu>
In-Reply-To: <4031AB8D.1040209@andrew.cmu.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170108.07271.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 12:50 am, Peter Nelson wrote:
> +module_param_array(gc, int, gc_count, 0);
> +module_param_array(gc_2, int, gc_2_count, 0);
> +module_param_array(gc_3, int, gc_3_count, 0);
> +module_param(gc_psx_delay, int, 0);
> +module_param(gc_psx_ddr, int, 0);

Nitpick: module_param, if module is compiled in, adds a prefix to parameter
names, so the parameters will be:
gamecon.gc
gamecon.gc_2
gamecon.gc_3
gamecon.gc_psx_delay
gamecon.gc_psx_ddr

At least with PSX stuff it would be nice to drop gc_ prefix.
 
-- 
Dmitry
