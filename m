Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbVAFUbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVAFUbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAFU3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:29:53 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33193 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263024AbVAFUPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:15:46 -0500
Date: Thu, 6 Jan 2005 12:15:31 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106201531.GJ1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105039259.4468.9.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 08:20:58PM +0100, Arjan van de Ven wrote:
> On Thu, 2005-01-06 at 11:05 -0800, Paul E. McKenney wrote:
> > Hello, Andrew,
> > 
> > Some export-removal work causes breakage for an out-of-tree filesystem.
> > Could you please apply the attached patch to restore the exports for
> > files_lock and set_fs_root?
> 
> 
> > diff -urpN -X ../dontdiff linux-2.5/fs/namespace.c linux-2.5-MVFS/fs/namespace.c
> > --- linux-2.5/fs/namespace.c	Wed Jan  5 13:54:22 2005
> > +++ linux-2.5-MVFS/fs/namespace.c	Wed Jan  5 17:12:08 2005
> 
> isn;t clearcase (mvfs) a binary only kernel module, and isn't it so that
> we don't export specifically for such (potentially license violating)
> modules ?

Yep, you win the prize, it is MVFS.

This is the usual port of an existing body of code to the Linux kernel.
It is not asking for a new export, only restoration of a previously existing
export.

							Thanx, Paul
