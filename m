Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTEHQyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTEHQyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:54:43 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:63694 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261866AbTEHQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:54:42 -0400
Date: Thu, 8 May 2003 17:10:42 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030508171042.V626@nightmaster.csn.tu-chemnitz.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <1052332566.752437@palladium.transmeta.com> <3EB95BD7.8060700@pobox.com> <20030507133856.02748f4e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030507133856.02748f4e.rddunlap@osdl.org>; from rddunlap@osdl.org on Wed, May 07, 2003 at 01:38:56PM -0700
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19DorV-0004Os-00*L8fhnKSA92g*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 01:38:56PM -0700, Randy Dunlap wrote:
> I've written a few of the stack reduction patches.  Lots of ioctl functions
> need work, so gcc handling it better would be good to have.
> 
> I have mostly used kmalloc/kfree, but using automatic variables is certainly
> cleaner to write (code).  One of the patches that I did just made each ioctl
> cmd call a separate function, and then each separate function was able to use
> automatic variables on the stack instead of kmalloc/kfree.  I prefer this
> method when it's feasible (and until gcc can handle these cases).

Wouldn't be a explicit union a better solution for the
switch-statement-issue? 

That way you still can use stack, are using even less of it and
have still all cases in place.

Regards

Ingo Oeser
-- 
Marketing ist die Kunst, Leuten Sachen zu verkaufen, die sie
nicht brauchen, mit Geld, was sie nicht haben, um Leute zu
beeindrucken, die sie nicht moegen.
