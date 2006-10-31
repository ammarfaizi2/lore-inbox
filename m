Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965520AbWJaFKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965520AbWJaFKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 00:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965518AbWJaFKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 00:10:19 -0500
Received: from nz-out-0102.google.com ([64.233.162.202]:17591 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965520AbWJaFKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 00:10:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=d1ebbA6ebVvFyyR/egQIdJBCLUo06AwO+n6yO0uA3ylKt1s3T0Zw7MkBbcQ9+2vc//CkCXB+oDKjC2DtVGRx6Nh7nRcHfKy2T5P9E7usJ4RpwNRrWNz+yBP/pqg2olKTov1fuER0/3NUN1WHbU656dWtgVGEBXWGLTB273UcimI=
Reply-To: andrew.j.wade@gmail.com
To: Greg KH <greg@kroah.com>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Date: Tue, 31 Oct 2006 00:09:54 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <20061030201123.5685529f.akpm@osdl.org> <20061031042032.GA12729@kroah.com>
In-Reply-To: <20061031042032.GA12729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310010.09759.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 23:20, Greg KH wrote:
> On Mon, Oct 30, 2006 at 08:11:23PM -0800, Andrew Morton wrote:
> > On Mon, 30 Oct 2006 22:58:11 -0500
> > Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> > 
> > > I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> > > crash go away.
> > 
> > How bizarre.  sysfs changes cause unexpected pte protection values?

Perhaps one of the drivers is responding badly to device_create
failing? (-EEXIST, if I'm not mistaken). 

> 
> That's just wrong.  Something odd is happening here.  Can you try to
> bisect things to determine the patch that is causing the problem?

Sure. 

Andrew Wade
