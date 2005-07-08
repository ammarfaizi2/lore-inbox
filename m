Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVGHW0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVGHW0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVGHWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:24:12 -0400
Received: from animx.eu.org ([216.98.75.249]:735 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262917AbVGHWXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:23:23 -0400
Date: Fri, 8 Jul 2005 18:41:06 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-ID: <20050708224106.GA10649@animx.eu.org>
Mail-Followup-To: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>,
	linux-kernel@vger.kernel.org
References: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net> <1120836958.16935.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120836958.16935.1.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Nickurak wrote:
> On ven, 2005-07-08 at 03:22 +0200, Bernd Eckenfels wrote:
> > No, it is creating files by appending just like any other file write. One
> > could think about a call to create unfragmented files however since this is
> > not always working best is to create those files young or defragment them
> > before usage.
> 
> Except that this defeats one of the biggest advantages a swap file has
> over a swap partition: the ability to easilly reconfigure the amount of
> hd space reserved for swap.

Of course, now this begs the question: Is it possible to create a large file
w/o actually writing that much to the device (ie uninitialized).  There's
absolutely no reason that a swap file needs to be fully initialized, only
part which mkswap does.  Of course, I would expect that ONLY root beable to
do this. (or capsysadmin or whatever the caps are)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
