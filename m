Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVIOPjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVIOPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVIOPjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:39:24 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:12663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030502AbVIOPjY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:39:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AwnJ7fo3C3G5T4oMRJPyrG72k6lqtIJonhPXT52a5wMl1YtfW4DcFIu8Kx9RBHvTwo3GN/LFLZajoJj5/3TWDiSFuDa3cXVCscPgDiP6ra0W0aXe8pBJSvXhXW/Q1R5FQNJ+78ND2HvwZKmYwktgu1l9FbXJpRCejRKJl9eriGg=
Message-ID: <1e62d13705091508391832f897@mail.gmail.com>
Date: Thu, 15 Sep 2005 20:39:23 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: ivan.korzakow@gmail.com
Subject: Re: best way to access device driver functions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a598610305091505184a8aa8fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a5986103050915004846d05841@mail.gmail.com>
	 <1e62d137050915010361d10139@mail.gmail.com>
	 <a598610305091505184a8aa8fd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Ivan Korzakow <ivan.korzakow@gmail.com> wrote:
> >
> > Adding ioctl in driver is not a good idea especially for 2.6.x series
> > kernel, rather use sysfs which is in kernel 2.6.x to support
> > user/kernel interaction too with other usage .....
> >
> 
> 
> Thanks for your answer. I started looking in sysfs and driver model.
> 
> Could you explain me why ioctl should be avoided ? Is it going to be
> deprecated in future kernel ?
> 

No ioctl are not deprecated, but they are just avoided b/c its not
good to mess kernel with new system-calls as there is a different way
for that !!!!

And for user/kernel interaction you have to look for sysfs/kobject and
don't need to go into the details of driver-model if you just need to
do user/kernel interaction and linux device driver 3rd edition's
chapter of driver-model will really help you in user/kernel
interaction (http://lwn.net/Kernel/ldd3/) ......  (for bi-directional
communication means kernel can also send messeges to user space you
can see netlink-sockets) .........


-- 
Fawad Lateef
