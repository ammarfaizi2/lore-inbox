Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVCXVO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVCXVO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVCXVO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:14:56 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:40561 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbVCXVOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:14:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eqbLwz2/u4k3PYBhKvpD+r7EPMYuMq/99mecD6WzZ53y1c/YgRyh3LfuJ1OLXiA4B5ErqakSNe3BfEqSNySflZ4soXlSpuzljInIkepk+JEWCjPErA1GWtUkANzEu5nLXhN3xrjVQ9ytdjkFp2RgxX+CVY7zk8wUJERMR0g5XE4=
Message-ID: <d120d50005032413145adaa283@mail.gmail.com>
Date: Thu, 24 Mar 2005 16:14:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050324202040.GC9005@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org>
	 <d120d500050324111826335f67@mail.gmail.com>
	 <20050324202040.GC9005@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 12:20:40 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> On Thu, Mar 24, 2005 at 02:18:40PM -0500, Dmitry Torokhov wrote:
> > On Thu, 24 Mar 2005 10:10:59 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> > > So I added i8042.noaux to my kernel command line, rebooted, insmodded
> > > intel_agp, started X, and verified no touchpad action.  Then I
> > > suspended, and it worked fine.  After restart, I suspended again - also
> > > fine.
> > >
> > > So I think that fixed it.  But no touchpad is a bit annoying. :)
> >
> > Try adding i8042.nomux instead of i8042.noaux, it should keep your
> > touchpad in working condition. Please let me know if it still wiorks.
> 
> With nomux the touchpad works again, but suspend blocks in the same
> place as without nomux.
> 
> (How can I verify that "nomux" was accepted?  It shows up on the "Kernel
> command line" but there's no other mention of it in dmesg.)
> 

Ignore my babbling, I just noticed in your dmesg that your KBC does
not support MUX mode to begin with.

-- 
Dmitry
