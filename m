Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbUKVSF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUKVSF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbUKVSFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:05:45 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22662 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262246AbUKVSCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:02:07 -0500
Date: Mon, 22 Nov 2004 10:01:54 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: Re: [PATCH 2/2] include/delay.h: replace msleep() and msleep_interruptible() with macros
Message-ID: <20041122180154.GA8442@us.ibm.com>
References: <20041117024944.GB4218@us.ibm.com> <20041120005601.GB7466@us.ibm.com> <20041120012332.GF6181@us.ibm.com> <200411201037.22237.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411201037.22237.oliver@neukum.org>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:37:21AM +0100, Oliver Neukum wrote:
> Am Samstag, 20. November 2004 02:23 schrieb Nishanth Aravamudan:
> > Description: Remove prototypes of msleep() and msleep_interruptible() to
> > prepare for the macro versions of these functions. Add macros for 4
> > types of sleeps:
> 
> What is the purpose of having macros for delay?
> They are on a slow path by definition. You want the smallest possible
> function call here, nothing fancy.

Just so I'm clear on what you are asking... Do you mean why am I using
macros or why the macros are needed at all?

To the former, I am more than happy to change them to functions, and, in
fact, I believe I have to for modules (EXPORT_SYMBOL_GPL?) to be able to
call the sleep functions.

To the latter, having these 4 functions/macros makes it clear for what
reason you are sleeping. It leads to *correct* functionality of the
code, which we do not currently have.

-Nish
