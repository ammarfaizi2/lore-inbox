Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135822AbREIDYq>; Tue, 8 May 2001 23:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbREIDYf>; Tue, 8 May 2001 23:24:35 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:34577 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135822AbREIDYQ>; Tue, 8 May 2001 23:24:16 -0400
Date: Tue, 8 May 2001 23:24:11 -0400
From: Matt Wilson <msw@redhat.com>
To: redhat-devel-list@redhat.com
Cc: linux-kernel@vger.kernel.org, Jeremy Hogan <jhogan@redhat.com>,
        Mike Vaillancourt <mikev@redhat.com>,
        Jim Wright <jwright@penguincomputing.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: Re: bug in redhat gcc 2.96
Message-ID: <20010508232411.B22615@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105081927320.1798-100000@foo.penguincomputing.com>; from jwright@penguincomputing.com on Tue, May 08, 2001 at 08:05:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was fixed in 2.96-82, see:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=37054

It was a bug in the if conversion optimization.

We're at 2.96-84 in rawhide now.

ftp://ftp.redhat.com/pub/redhat/linux/rawhide/

Cheers,

Matt
msw@redhat.com

On Tue, May 08, 2001 at 08:05:06PM -0700, Jim Wright wrote:
> We believe we have found a bug in gcc.  We have been trying to track
> down why the .../drivers/scsi/sym53c8xx.c driver oopses with a divide
> by zero when initializing at line 5265, which reads:
