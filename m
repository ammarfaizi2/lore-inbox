Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293592AbSCEE2e>; Mon, 4 Mar 2002 23:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293598AbSCEE2Y>; Mon, 4 Mar 2002 23:28:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38167 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293592AbSCEE2N>; Mon, 4 Mar 2002 23:28:13 -0500
Date: Mon, 4 Mar 2002 23:28:06 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020304232806.A31622@redhat.com>
In-Reply-To: <E16i1IV-0000ss-00@the-village.bc.nu> <200203050415.XAA06766@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203050415.XAA06766@ccure.karaya.com>; from jdike@karaya.com on Mon, Mar 04, 2002 at 11:15:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 11:15:56PM -0500, Jeff Dike wrote:
> So, does this make things at all clearer?  Without the patch I get random
> UML deaths when tmpfs can't back a page.  With it, tmpfs is forced to back
> newly allocated pages when they're allocated, and the allocation returns NULL
> if it can't.  The result being I get no UML deaths and fairly reasonable 
> behavior.

>From your explanation of things, you only need to do the memsets once at 
startup of UML where the ram is allocated -> a uml booted with 64MB of 
ram would write into every page of the backing store file before even 
running the kernel.  Doesn't that accomplish the same thing?

		-ben
