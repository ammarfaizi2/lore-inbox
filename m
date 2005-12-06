Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVLFSmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVLFSmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVLFSmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:42:39 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:28351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965010AbVLFSmi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:42:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nuIfJr1dwmzhbxble3zGB3gSiKcEWFmyoUYvy6jpisOUPNVr02R/scEyMCbinWvV5YJ8/km1pY7pXJM74xnlt3+IUt9uA8AbGMV74YoJcszr/a9BnqLaEWvt35OhVqypAodlDc4AxJgTbA5EvEN+O4Gev8wzGWA3AvZlCpjyRj8=
Message-ID: <d120d5000512061042j36a6c0a3gd784d087c40f0f75@mail.gmail.com>
Date: Tue, 6 Dec 2005 13:42:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andi Kleen <ak@suse.de>
Subject: Re: Policy for reverting user ABI breaking patches was Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <p73hd9lrga8.fsf_-_@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com>
	 <20051204115650.GA15577@merlin.emma.line.org>
	 <20051204232454.GG8914@kroah.com> <20051205185110.GJ9973@stusta.de>
	 <20051206175017.GF3084@kroah.com> <p73hd9lrga8.fsf_-_@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Dec 2005 15:50:55 -0700, Andi Kleen <ak@suse.de> wrote:
> And if there is breakage of such kernel-near applications there should
> be an *extremly* good reason for this (and minor cleanup isn't such a
> reason). For example for the recent udev breakage imho the cleanup
> patch that caused this should have just been reverted.

It was not a cleanup patch, without it you could not get input events
through netlink.

I wonder, since udev is fairly closely tied to the kernel, meybe it
woudl be beneficial just to fold it in. This way we could keep
compatibility with older kernels and rapidly roll out never stuff.

--
Dmitry
