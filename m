Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVFVKUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVFVKUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVFVKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:18:10 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:56016 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262828AbVFVKLI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:11:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=asIhS+dsRk6Tw4o1ViP85euGaBVrx7SqFpcgvPF3+pt5Mgfn0VgZXNvoM4RpMHWojQH32mgkfyiooMc9N5Kqf4OcGmUZp/SOf/AU35WEo//8wvc7y6OBCqijueCVFoDK1elKpQEFWVywaIsxPCLce4PpAP6DRMzh2kkJrQ85sCs=
Message-ID: <2cd57c9005062203112f23f89b@mail.gmail.com>
Date: Wed, 22 Jun 2005 18:11:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [question] pass CONFIG_FOO to CC problem
Cc: lkml <linux-kernel@vger.kernel.org>, sam@ravnborg.org
In-Reply-To: <1119434071.16554.4.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c90050622013937d2c209@mail.gmail.com>
	 <1119434071.16554.4.camel@icampbell-debian>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Ian Campbell <ijc@hellion.org.uk> wrote:
> On Wed, 2005-06-22 at 16:39 +0800, Coywolf Qi Hunt wrote:
> > Hello,
> >
> > I was expecting kbuild passes CONFIG_FOO from .config to CC
> > -DCONFIG_FOO, but it doesn't.  So I have to add
> >
> > ifdef CONFIG_FOO
> > EXTRA_CFLAGS += -DCONFIG_FOO
> > endif
> >
> > Is that the right way? thanks in advance.
> 
> I think you need to #include <linux/config.h>

Yes, exactly. thanks
