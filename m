Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVASD66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVASD66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 22:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVASD66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 22:58:58 -0500
Received: from ozlabs.org ([203.10.76.45]:41638 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261554AbVASD64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 22:58:56 -0500
Subject: Re: [BUG] MODULE_PARM conversions introduces bug in Wavelan driver
From: Rusty Russell <rusty@rustcorp.com.au>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20050119004722.GA26468@bougret.hpl.hp.com>
References: <20050119004722.GA26468@bougret.hpl.hp.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 13:42:33 +1100
Message-Id: <1106102553.20879.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 16:47 -0800, Jean Tourrilhes wrote:
> 	Hi Rusty,
> 
> 	(If you are not the culprit, please forward to the guilty party).

Almost certainly me.  We gave people warning, we even marked MODULE_PARM
deprecated, but eventually I had to roll through and try to autoconvert.

> 	I personally introduced the "double char array" module
> parameter, 'c', to fix that. I even sent you the patch to add 'c'
> support in your new module loader (see set_obsolete()). Would it be
> possible to carry this feature with the new module_param_array ?
> 	Thanks in advance...

Actually, it's designed so you can extend it yourself: at its base,
module_param_call() is just a callback mechanism.

Thanks!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

