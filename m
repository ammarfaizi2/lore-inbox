Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVCVOU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCVOU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVCVOUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:20:55 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:9209 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261266AbVCVOUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:20:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=P2Wx2AwfDJkr15Ug7c96gPpM0uXKdo/0w84lE1c4dr5qUI81bDkA0jO/2EJf0xXk2qc63UU28eYIlTgv95V9S9RZeyE27FgtmlpPjac+F1nBxEAwp3I2lGs+ytvWYZWysp7fTv7QWx+MS8FOTsYChMp6ZAy0BpwfiC+mxS0g0Ig=
Message-ID: <d120d50005032206205ab21753@mail.gmail.com>
Date: Tue, 22 Mar 2005 09:20:48 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
In-Reply-To: <20050322100114.GI2810@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050217194217.GA2458@ucw.cz>
	 <d120d500050321065261ee815c@mail.gmail.com>
	 <1111419068.8079.15.camel@localhost>
	 <200503220213.46375.dtor_core@ameritech.net>
	 <20050322100114.GI2810@pazke>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 13:01:14 +0300, Andrey Panin <pazke@donpac.ru> wrote:
> On 081, 03 22, 2005 at 02:13:45AM -0500, Dmitry Torokhov wrote:
> > On Monday 21 March 2005 10:31, Kenan Esau wrote:
> > > Am Montag, den 21.03.2005, 09:52 -0500 schrieb Dmitry Torokhov:
> > > >
> > > > There are couple of things that I an concerned with:
> > > >
> > > > 1. I don't like that it overrides meaning of max_proto parameter to be
> > > > exactly the protocol specified.
> > >
> > > Yeah -- I agree. I also don't like that double-meaning. That was the
> > > reason why I originally proposed the use of a new parameter...
> > >
> >
> > Ok, I have some patches to lifebook that I would like to included (if
> > they work):
> >
> > 1. lifebook-dmi-x86-only - do not compile in DMI detection on anything
> >    but x86.
> 
> On !x86 machines DMI functions will be optimized away and so you'll save only
> few bytes in .init.data section. IMHO it's not worth additional ugly #ifdef's.
> 

It is not in .init.data, it is not discarded... Still probably OK to
keep. Not quite sure.

-- 
Dmitry
