Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWBTOBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWBTOBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBTOBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:01:47 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:18777 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030230AbWBTOBr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:01:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xhnqt4QxPIBzbScG2wrIrvQdZaPa3FIvzJLfRKY5nhg0rJgN83Zp1wOrKlky6uXCoHJJB9qZPhREOywkui6IQvCG2e1SAXpTWhLCO60NdiXKWlHzWXUrnI3mqoUfcIEwCFXWN1jjkX2KT6rI49n/UlrjdZ+nuCOjHetFJTOqxzc=
Message-ID: <d120d5000602200601l31382264i7c0ef5bdf3d3829a@mail.gmail.com>
Date: Mon, 20 Feb 2006 09:01:45 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "Matthias Hensler" <matthias@wspse.de>, "Pavel Machek" <pavel@suse.cz>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
In-Reply-To: <1140429758.3429.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602091926.38666.nigel@suspend2.net>
	 <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org>
	 <20060211104130.GA28282@kobayashi-maru.wspse.de>
	 <20060218142610.GT3490@openzaurus.ucw.cz>
	 <20060220093911.GB19293@kobayashi-maru.wspse.de>
	 <1140429758.3429.1.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > It is slightly slower,
> >
> > Sorry, but that is just unacceptable.
>
> Um... suspend2 puts extra tests into really hot paths like fork(), which
> is equally unacceptable to many people.
>

How bad is it really? From what I saw marking that swsuspend2 branch
with "unlikely" should help the hot path.

> Why can't people understand that arguing "it works" without any
> consideration of possible performance tradeoffs is not a good enough
> argument for merging?

Many of Pavel's arguments are not about performance tradeoffs but
about perceived complexity of the code. I think if Nigel could run a
clean up on his implementation and split it into couple of largish
(not for inclusion but for general overview) pieces, like separate
arch support, generally useful bits and the rest it would allow seeing
more clearly how big and invasive swsuspend2 core is.

--
Dmitry
