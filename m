Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUHCAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUHCAcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUHCAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:30:15 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:22485 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264677AbUHCA2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:28:04 -0400
Subject: Re: [UPDATED PATCH 1/2] export module parameters in sysfs for
	modules _and_ built-in code
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Greg KH <greg@kroah.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802214710.GB7772@dominikbrodowski.de>
References: <20040801165407.GA8667@dominikbrodowski.de>
	 <1091426395.430.13.camel@bach>  <20040802214710.GB7772@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1091492861.426.112.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:27:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 07:47, Dominik Brodowski wrote:
> Thanks for your feedback, Rusty.

Hey, thanks for the code!


> > > +/* Needs to be before __initcall(module_init) */
> > > +fs_initcall(param_sysfs_init);
> > 
> > That's horrible.  And I think the initcall in module.c should be removed
> > in your second patch, no?
> 
> Actually, it could have remained __initcall... and the one in module.c is
> needed as we still register a module subsystem. This updated patch doesn't
> add an own initcall in params.c, though, but rather param_sysfs_init() gets
> called by module_init.

It's logically separate, IMHO.  I'm thinking about CONFIG_MODULES=n
here...

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

