Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVCRQI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVCRQI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCRQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:04:41 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:50149 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261662AbVCRQC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:02:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ka2goHvVGBvQlvnsOHMsAQ8Dlbt34a4kHgE78K4ke14Q4mMRXDec01Sqd8jG8BFsLPJ71xonWFhW7JdllhamTxXvVGyrKkqheN6dJfOKI8tha8nRgFQ/pQZovjdJBonK63pVOYX/GNWeJoON9Y6k0PbNuLQP4bSccS5fh0Q0fBA=
Message-ID: <d120d50005031808027102fa9c@mail.gmail.com>
Date: Fri, 18 Mar 2005 11:02:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH] DM9000 network driver
Cc: Hong Kong Phoey <hongkongphoey@gmail.com>,
       Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050318152554.GH17865@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050318133143.GA20838@metis.extern.pengutronix.de>
	 <4f6c1bdf0503180711148b8f02@mail.gmail.com>
	 <20050318152554.GH17865@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 10:25:54 -0500, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Fri, Mar 18, 2005 at 08:41:52PM +0530, Hong Kong Phoey wrote:
> > Sacrificing readibility a little bit, you could do something useful.
> > Instead of those ugly switch statements you could define function
> > pointer arrays and call appropriate function
> >
> > switch(foo) {
> >
> >   case 1:
> >              f1();
> >   case2 :
> >              f2();
> > };
> >
> > could well become
> >
> > void (*func)[] = { f1, f2 };
> >
> > func(i);
> 
> Ewww!
> 
> How about sticking with obvious readable code rather than trying to save
> a couple of conditional branches.

On top of that I highly doibt that setting up stack frame for an
indirect function call is less expensive than a conditional branch.

-- 
Dmitry
