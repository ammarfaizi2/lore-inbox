Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281358AbRKLImS>; Mon, 12 Nov 2001 03:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281360AbRKLImI>; Mon, 12 Nov 2001 03:42:08 -0500
Received: from smtp-rt-11.wanadoo.fr ([193.252.19.62]:49813 "EHLO
	magnolia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281358AbRKLIl6>; Mon, 12 Nov 2001 03:41:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Mathijs Mohlmann <mathijs@knoware.nl>
Subject: Re: tasklets and finalization
Date: Mon, 12 Nov 2001 09:41:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011112093536.mathijs@knoware.nl>
In-Reply-To: <XFMail.20011112093536.mathijs@knoware.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E163Ceo-0000Si-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 November 2001 9:35 am, Mathijs Mohlmann wrote:
> On 12-Nov-2001 Duncan Sands wrote:
> > ...
> > tasklet_schedule(&my_tasklet);
> > tasklet_kill(&my_tasklet);
> > ...
> >
> > Since (as far as I can see) there is no way the
> > tasklet will run before calling tasklet_kill, this
> > should just kill any pending tasklets.
>
> cpu#1           cpu#2
> tasklet_schedule
>                 tasklet_schedule
> run tasklet
>                 tasklet_kill
>                 loop

Aaargh!  I should think before typing.  It is too
early in the morning here...

Duncan.
