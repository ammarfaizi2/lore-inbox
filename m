Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTKBGXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 01:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKBGXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 01:23:47 -0500
Received: from dp.samba.org ([66.70.73.150]:9904 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261476AbTKBGXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 01:23:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petri Koistinen <petri.koistinen@iki.fi>
Cc: cltien@cmedia.com.tw, support@cmedia.com.tw
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove one of sound/oss/cmpci.c compile warnings 
In-reply-to: Your message of "Tue, 28 Oct 2003 20:14:53 +0200."
             <Pine.LNX.4.58.0310282002530.4918@dsl-hkigw4g29.dial.inet.fi> 
Date: Sun, 02 Nov 2003 16:05:16 +1100
Message-Id: <20031102062345.C0B602C102@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0310282002530.4918@dsl-hkigw4g29.dial.inet.fi> you write:
> Hi!
> 
> This patch removes this compile warning:
> 
> sound/oss/cmpci.c: In function `cm_release_mixdev':
> sound/oss/cmpci.c:1465: warning: unused variable `s'
> 
> GCC doesn't seem to unstand that VALIDATE_STATE macro uses s variable.
> I hope this is correct way to fix this.

Because it doesn't.  A better change would be:

VALIDATE_STATE((struct cm_state *)file->private_data);

Or to remove the entire function.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
