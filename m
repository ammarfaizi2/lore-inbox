Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUBHXGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBHXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:06:49 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:7296 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264374AbUBHXGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:06:48 -0500
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ?
From: David Woodhouse <dwmw2@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, davem@redhat.com
In-Reply-To: <20040208230331.79FEB2C003@lists.samba.org>
References: <20040208230331.79FEB2C003@lists.samba.org>
Content-Type: text/plain
Message-Id: <1076281602.8563.1.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 08 Feb 2004 23:06:43 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-09 at 10:00 +1100, Rusty Russell wrote:
> > we now support architectures in 2.6 where alignment fixups _cannot_ happen,
> > and the cost of the 'exception' case should be considered infinite.
> 
> Um, we do?  I thought it was compulsory in the kernel, otherwise
> networking breaks on packets w/ wierd hardware headers.

We do. It breaks. I'm trying to come up with a solution for it which
actually lets us optimise elsewhere too, and hence has at least a
whelk's chance in a supernova of being accepted... :)

-- 
dwmw2


