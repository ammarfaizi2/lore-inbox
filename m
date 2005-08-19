Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVHSQFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVHSQFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVHSQFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:05:00 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:50711 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751201AbVHSQFA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:05:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sknP7IY1koumTV9GSQNkeG5gWOhDm+/JdEm8ayH4N1X8jT4xRqpyLbINEpMqnNZ45+bg7U1vgNigtFPkPPs6Pi88Z3qCcpJS+srBL9uPjF6Azx7oo4DZ9Oin/jKLhrEhKNMOmZl4QCM5dRyASz3JRM0qTwFr5/CKDO0yu8X26gY=
Message-ID: <40f323d0050819090473d2c268@mail.gmail.com>
Date: Fri, 19 Aug 2005 18:04:53 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.6.13-rc6-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200508191145.58835.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	 <200508191145.58835.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Ed Tomlinson <tomlins@cam.org> wrote:
> On Friday 19 August 2005 07:33, Andrew Morton wrote:
> > - Lots of fixes, updates and cleanups all over the place.
> >
> > - If you have the right debugging options set, this kernel will generate
> > a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
> > It is being worked on.
> >
> >
> > Changes since 2.6.13-rc5-mm1:
> >
> 
> Hi,
> 
> It does not compile here:
> 
>   CC      drivers/acpi/sleep/main.o
> In file included from drivers/acpi/sleep/main.c:15:
> include/linux/dmi.h:55: error: field 'list' has incomplete type
> make[3]: *** [drivers/acpi/sleep/main.o] Error 1
> make[2]: *** [drivers/acpi/sleep] Error 2
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
> ed@grover:/usr/src/13-6-1$
> 
> Probably a missing include?  Note that this is a non smp x86_64 build.
> 
including <linux/list.h> in dmi.h should work

regards,

Benoit
