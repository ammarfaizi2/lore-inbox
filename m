Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWD1RDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWD1RDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWD1RDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:03:52 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:16967 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751772AbWD1RDt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:03:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AB2U2KqXIHtpQRIJtVn7yP2OdUM59S4zkHDBKDdkcfvcmuE9n3PiisVqgT0UDT7CxFycGOgL2WQVvxRnz84j+Ydch48BbAYZP3ls3Wf+u5lUK5dlSknY3DztL+dS2lQ9hX5BXvFk59Pn7IyoiLeitHF4m35dCgr6yH4h1f3U9c4=
Message-ID: <d120d5000604281003y530d742el5c12b83fc7011af4@mail.gmail.com>
Date: Fri, 28 Apr 2006 13:03:38 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: bjdouma <bjdouma@xs4all.nl>
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060426190908.GA19282@skyscraper.unix9.prv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060422204844.GA16968@skyscraper.unix9.prv>
	 <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com>
	 <20060425152600.GA30398@suse.cz>
	 <200604260106.38480.dtor_core@ameritech.net>
	 <20060426104301.GA4634@skyscraper.unix9.prv>
	 <d120d5000604260724q45f52117t27920f2ae59bea76@mail.gmail.com>
	 <20060426190908.GA19282@skyscraper.unix9.prv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/06, bjdouma <bjdouma@xs4all.nl> wrote:
>
> Basically what I'm saying is that when you query the input driver
> for the state of EV_SND, it doesn't tell you much about what tone
> is actually audible, if at all.
>

I agree but I still questinon usefullness of that data.

> Let me give two examples.  I am using here my program inputcntrl
> that I am working on -- basically a wrapper with a parser and
> interpreter around some of the uinput driver's functions (if you
> want a copy of the WIP tree, let me know).
>
> Just regard both examples as a complete session, i.e. no other
> commands influencing the pcspkr are interspersed in what you see
> below (/dev/input/pcspkr happens to be a symlink to /dev/input/event1).
>
> These examples are with your latest small patch in place, the one
> doing the change_bit(code, dev->snd).
>

<..skipped..>

OK, so the first example illustrates that input core does not provide
"tone" data - no surprise here. The scond example proves that pcspkr
driver does not handle concurrent access very well. Still the input
core behaved exactly as it was supposed to, everythng is fine as far
as I can see.

--
Dmitry
