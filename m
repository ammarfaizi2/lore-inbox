Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbSIPSLs>; Mon, 16 Sep 2002 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262772AbSIPSLs>; Mon, 16 Sep 2002 14:11:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:25009 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262770AbSIPSLs>; Mon, 16 Sep 2002 14:11:48 -0400
Subject: Re: BUG: sym53c8xx_2 and highmem_io
From: Todd Inglett <tinglett@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Gerard Roudier <groudier@free.fr>
In-Reply-To: <1032198591.18300.22.camel@q.rchland.ibm.com>
References: <1032198591.18300.22.camel@q.rchland.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Sep 2002 13:16:42 -0500
Message-Id: <1032200203.18299.27.camel@q.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 12:49, Todd Inglett wrote:

> However, sym53c8xx_2 fails because after calling scsi_register() in its
> attach it blindly slams highmem_io on (in sym_glue.c).  Is this
> correct?  It seems to me that it should just leave it alone since
> scsi_register already handled that.

It's interesting that in 2.5 this assignment is still there, but the
driver works.  However, scsi_merge.c is very different.  I won't pretend
to know the scsi layer that well :).

Maybe the real fix is still somewhere else....

-todd

