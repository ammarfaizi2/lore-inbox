Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbUJWVO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUJWVO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 17:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUJWVO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 17:14:58 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:49869 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261320AbUJWVO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 17:14:56 -0400
Date: Sat, 23 Oct 2004 21:14:53 +0000
From: Willem Riede <wrlk@riede.org>
Reply-To: wrlk@riede.org
Subject: Re: Should osst call cdev_alloc()
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
References: <1098551404l.3844l.1l@serve.riede.org>
	<Pine.LNX.4.61.0410232336510.6707@kai.makisara.local>
In-Reply-To: <Pine.LNX.4.61.0410232336510.6707@kai.makisara.local> (from
	Kai.Makisara@kolumbus.fi on Sat Oct 23 16:56:06 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1098566093l.3844l.2l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2004 04:56:06 PM, Kai Makisara wrote:
> On Sat, 23 Oct 2004, Willem Riede wrote:
> 
> > Currently, sg.c and st.c contain calls to cdev_alloc() and friends:
> >
> > My question is: should osst do the same? It seems to work just fine
> without.
> >
> The reason why st.c calls cdev_alloc() directly is that this allows it to
> use the large minor numbers (some people want to use more than 32 tapes).
> This also used to give presence in sysfs but that is not the case any
> more. The devices can be shown in sysfs using device classes (st.c uses
> the class_simple_* functions).
> 
> Osst does call cdev_alloc() indirectly through register_chrdev(). This is
> the link between the "old style" character device allocation and the
> current method. As long as register_chrdev() exists, you don't have any
> pressing need to change osst unless you want to support more than 256
> minors.

Thanks. Given that the Onstream devices were targeted at the low end market, I  
see no need to support many drives of this type, so I'll leave it as it is.

Willem Riede.


