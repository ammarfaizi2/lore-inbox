Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWDGLCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWDGLCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGLCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:02:20 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:25150 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932435AbWDGLCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:02:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=akRq0umVTtoA/oT97SF4CehmexQyDb+yWwXBdcYI0bcLHvgxTxV60lOmEVpoZD1U5S7HzzVehA0aRIWlxPmJ4lqxyloy7k87/MTXcdpSSQlHTEG3vU/cViQS30TQLut7GOJHPj8bcMtNyhnncV5qzJB8IsE9RfkOHGq7PFgxuZM=
Message-ID: <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
Date: Fri, 7 Apr 2006 14:02:18 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: add new code section for kernel code
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
In-Reply-To: <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
	 <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the arch/arm/boot/compressed/ files compiled with
ffunction-sections switch, so I added the -fno-function-sections to
the EXTRA_CFLAGS of the compressed/Makefile. And this solved the
problem.



On 4/6/06, saeed bishara <saeed.bishara@gmail.com> wrote:
> Hi,
>     I've tried to port this to my kernel (2.6.12.6), but the kenel
> fails to boot; it stops after Starting kernel ....
>    I tried to add only the CFLAGS += -ffunction-sections to the
> arch/arm/Makefile, and it still fails. my tool chains is "gcc version
> 3.4.4 (release) (CodeSourcery ARM 2005q3-2)"
> any ideas?
