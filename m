Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUKHWKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUKHWKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbUKHWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:10:45 -0500
Received: from users.linvision.com ([62.58.92.114]:51083 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261265AbUKHWKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:10:41 -0500
Date: Mon, 8 Nov 2004 23:10:25 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't divide by 0 when trying to mount ext3
Message-ID: <20041108221025.GA19823@bitwizard.nl>
References: <20041108195934.GA29981@apps.cwi.nl> <20041108212711.GA16365@bitwizard.nl> <20041108215402.GB2946@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108215402.GB2946@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 10:54:02PM +0100, Andries Brouwer wrote:
> On Mon, Nov 08, 2004 at 10:27:11PM +0100, Rogier Wolff wrote:
> 
> > There are now three cases that end up with the same message and
> > same error from userspace viewpoint. There are many cases where 
> > debugging a problem is helped when it's possible to find out exactly
> > which test determined that the filesystem could not be mounted. 
> 
> Strings are expensive. Don't like to add worthless code.
> We lived without this for years, so it is not a frequent occurrence.
> If you have a bad ext2/ext3 system, e2fsck will find what is wrong.

   int cpos=0;

   if (++cpos && (errorposibility1 ) ) goto error_handling;
[...]
   if (++cpos && (errorposibility2 ) ) goto error_handling;
[...]
   if (++cpos && (errorposibility3 ) ) goto error_handling;
[...]
error_handling:

     printk (".... %d ...", cpos); 

Rogier. 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
