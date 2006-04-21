Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWDUODF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWDUODF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDUODF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:03:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59033 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932304AbWDUODC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:03:02 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: searching exported symbols from modules
Date: Fri, 21 Apr 2006 07:03:07 -0700
User-Agent: KMail/1.8.3
Cc: "Antti Halonen" <antti.halonen@secgo.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <14930.1145604787@kao2.melbourne.sgi.com>
In-Reply-To: <14930.1145604787@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604210703.07856.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 00:33, Keith Owens wrote:
> "Antti Halonen" (on Wed, 19 Apr 2006 16:08:37 +0300) wrote:
> >Hi Dick,
> >
> >Thanks for your response.
> >
> >> `insmod` (or modprobe) does all this automatically. Anything that's
> >> 'extern' will get resolved. You don't do anything special. You can
> >> also use `depmod` to verify that you won't have any problems loading.
> >> `man depmod`.
> >
> >Yes, I know insmod and herein the problem lies. I have a module where
> >I want to use functions provided by another module, _if_ it is present,
> >otherwise use modules internal functions.
>
> symbol_get() and symbol_put().  See include/linux/module.h.  If
> symbol_get() returns NULL then the symbol does not exist.

The trick with symbol_get is that it is marked as EXPORT_SYMBOL_GPL, so only 
GPL modules can use it.  Not that that is a bad thing though. :)

If you want all of these nice kernel features, GPL your module!

--Vernon
