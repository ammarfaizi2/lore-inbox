Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWCZHOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWCZHOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 02:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWCZHOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 02:14:51 -0500
Received: from nproxy.gmail.com ([64.233.182.185]:58685 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751133AbWCZHOu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 02:14:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kjow/WOceCU2MKUt3Qp04Ezasb7DK18mB8G9oIG7uA4GJ1GMwEE0xBLLc/srvTzXyq3RvsejJ+ejpkZ3snKSGQ3UovZHflVA+MPwwp01SVguQArKSMLC9RiAUDeCy983EZiF//UNJPKIJDeLdoLj936ZsZllITpwoIRg7b2ZLW0=
Message-ID: <40f323d00603252314k24e49f82q601e19c85ab0d5d3@mail.gmail.com>
Date: Sun, 26 Mar 2006 08:14:48 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Greg Stark" <gsstark@mit.edu>
Subject: Re: Connector: Filesystem Events Connector v3
Cc: yang.y.yi@gmail.com, "David S. Miller" <davem@davemloft.net>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       johnpol@2ka.mipt.ru, matthltc@us.ibm.com
In-Reply-To: <8764m2i08f.fsf@stark.xeocode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <20060323.230649.11516073.davem@davemloft.net>
	 <4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com>
	 <8764m2i08f.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 2006 18:16:32 -0500, Greg Stark <gsstark@mit.edu> wrote:
>
> yang.y.yi@gmail.com writes:
>
> > the filesystem events connector is small and has low overhead, it only
> > focuses on activities in the filesystem, so I think it should be an option
> > for those users which just concerns events in the filesystem. audit dose do
> > this, but it is complicated and overhead is big, I believe the filesystem
> > events connector is useful, but it maybe need to be improved further.
>
> Would this be a good tool to tell me why I hear my hard drive stutter
> periodically? This is above the regular buffer flushing.
>
> I'm curious what application is causing this file i/o since I have plenty of
> free RAM so the only reason it would be hitting disk is if something is
> calling fsync gratuitously.
>
blktrace (included at least in -mm) will tell you.

You have to activate BLK_DEV_IO_TRACE and use blktrace from
http://www.kernel.org/pub/linux/kernel/people/axboe/blktrace/

regards,

Benoit
