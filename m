Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVBYUIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVBYUIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVBYUIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:08:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:24967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261290AbVBYUI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:08:27 -0500
Date: Fri, 25 Feb 2005 12:07:46 -0800
From: Greg KH <greg@kroah.com>
To: Mickey Stein <yekkim@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [i2c]: Fix some gcc 4.0 compile failures and warnings
Message-ID: <20050225200746.GC25915@kroah.com>
References: <421CFFDC.90806@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421CFFDC.90806@pacbell.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 02:12:44PM -0800, Mickey Stein wrote:
> From: Mickey Stein
> Versions:   linux-2.6.11-rc4-bk11, gcc4 (GCC) 4.0.0 20050217 (latest fc 
> rawhide from 19Feb DL)
> 
> gcc 4.0.x cvs seems to dislike "include/linux/i2c.h file" and others 
> due to a current gcc 4.0.x change having to do with
> array declarations.
> 
> Example error msg:   include/linux/i2c.h:{55,194} error: array type has 
> incomplete element type
> 
> A. Daplas has recently done a workaround for this on another header 
> file. A thread discussing this
> can be found by following the link below:
> 
> http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
> 
> The patch changes the array(struct i2c_msg) declaration used by 
> *i2c_transfer and *master_xfer
> from "struct i2c_msg msg[]" format to "struct i2c_msg *msg".
> 
> After some grepping, I came up with about a dozen files that used the 
> format disliked by gcc4 that're addressed by the attached patch.
> Tested on gcc 3.x & gcc 4.x by configuring kernel with all i2c switches 
> enabled as module, and saw no errors or warnings in i2c.
> 
> Signed-off-by: Mickey Stein <yekkim@pacbell.net>

Applied, thanks.

greg k-h

