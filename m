Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVAaWjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVAaWjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVAaWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:39:34 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:12389 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261412AbVAaWjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:39:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dWvYpPgmx3gW1oHrxbPwxW5ppGTEdL9B7DGwTL+1hTRRbfJOU5Aay/QYmi3/Cv3AbweE/hYIjpvWwf/8K59czUz1YqQii6oLdP+dzzR8FxNYnN7RHr4nr7xckf4u8VNTTxovW9KKS5S93cJSZ0q3XF7AUfEcis4ivIQqiC6LAL4=
Message-ID: <d120d5000501311439261775f@mail.gmail.com>
Date: Mon, 31 Jan 2005 17:39:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>, dtor_core@ameritech.net,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/sonypi.c: make 3 structs static
In-Reply-To: <20050131222753.GG28886@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050131173508.GS18316@stusta.de>
	 <20050131214905.GF28886@deep-space-9.dsnet>
	 <d120d500050131141358ff63c9@mail.gmail.com>
	 <20050131222753.GG28886@deep-space-9.dsnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 23:27:54 +0100, Stelian Pop <stelian@popies.net> wrote:
> On Mon, Jan 31, 2005 at 05:13:22PM -0500, Dmitry Torokhov wrote:
> 
> > On Mon, 31 Jan 2005 22:49:05 +0100, Stelian Pop <stelian@popies.net> wrote:
> > >
> > > sonypi.h is a "local" header file used only by sonypi.c.
> > >
> > > I would like to keep those tables in sonypi.h rather than putting
> > > all into sonypi.c (or we could as well remove sonypi.h and put all the
> > > contents into the .c).
> > >
> >
> > Hi,
> >
> > What is the point of having an .h file if it is not used by anyone?
> > Judging by the fact that it completely protected by #ifdef __KERNEL__
> > there should be no userspace clients either.
> >
> > I always thought that the only time .h is needed is when you define
> > interface to your code. I'd fold it to sonpypi.c.
> 
> It isn't strictly *needed*, but it does separate a bit the data
> structures and the constants (in the .h) from the code (in the .c).

Right, but why is it a good thing? Is it more convenient to
review/edit 2 files instead of one? And that header even defines (as
opposed to declaring) bunch of static variables in header file. They
are internal to the module, they do not form an _interface_.
 
-- 
Dmitry
