Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVIVBGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVIVBGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVIVBGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 21:06:13 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:32728 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965200AbVIVBGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 21:06:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZDDrisysOQTRjZCxbGASGnTJN0cin/6T7UbwGZQJrAX6XVSHORT9cHforEcN9AdtuzRo89OxHLK1gn78nWn0sbqEhfj9pjly1kKcsIX5xp6xrK3Xi6JS9ugX06Xb7dkvpw9ef0OGnrwu27zqpC+Cf9frBgxmCBqmof+j+BGlHjU=
Message-ID: <2cd57c900509211806291f7b77@mail.gmail.com>
Date: Thu, 22 Sep 2005 09:06:12 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Query: How fix: `ide_generic_all_on' defined but not used??
Cc: gcoady@gmail.com, grant_lkml@dodo.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20050921172835.005caf11.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mpn3j1p9n087sq45le5tio0np8aoa3s11a@4ax.com>
	 <20050921172835.005caf11.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/05, Andrew Morton <akpm@osdl.org> wrote:
> Grant Coady <grant_lkml@dodo.com.au> wrote:
> >
> > drivers/ide/pci/generic.c:45: warning: `ide_generic_all_on' defined but not used
> >
> >
> >  Source:
> >  ...
> >  static int ide_generic_all;             /* Set to claim all devices */
> >
> >  static int __init ide_generic_all_on(char *unused)
> >  {
> >          ide_generic_all = 1;
> >          printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
> >          return 1;
> >  }
> >
> >  __setup("all-generic-ide", ide_generic_all_on);
> >  ...
> >
> >  How to silence this type of warning?
>
> You could try poking around in the __setup() definition, using
> __attribute_used__, perhaps.
>

Weird, we have many such things, but we don't get this warning there.
Look at __setup() in main.c.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
