Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUC3XsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUC3XsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:48:24 -0500
Received: from ozlabs.org ([203.10.76.45]:16613 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261790AbUC3XsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:48:16 -0500
Subject: Re: Problems module autoload in 2.6.x
From: Rusty Russell <rusty@rustcorp.com.au>
To: Thomas Steudten <alpha@steudten.com>
Cc: linux-admin@vger.kernel.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4069CCEC.2080802@steudten.com>
References: <4051DA6E.6070809@steudten.com> <1079490472.3400.114.camel@bach>
	 <4069CCEC.2080802@steudten.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1080690492.11048.46.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 09:48:12 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 05:39, Thomas Steudten wrote:
> In kernel 2.6.x, I use 2.6.4, the option -k to
> modprobe is gone. Also the request_module() call
> in the kernel source, don´t set this option.
> The lsmod or cat /proc/modules don't gives
> the string "(autoclean)" any more. But that's
> another point, don't know why this is gone..

Because there's no autocleaning of modules any more.  You'd
wipe out your network modules every time, for a start.

> If I call mdir a:, the floppy module
> isn´t requested in request_module().

To debug this, please create a dummy modprobe like I suggested before.
That will tell you (1) whether modprobe is being called when you do
an mdir, and (2) what module it's asking for.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

