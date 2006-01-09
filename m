Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWAIU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWAIU7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWAIU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:59:47 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:31293 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751335AbWAIU7r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:59:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PV84WBkLm9wX+RBJ5zLj+pGMQFRmeLq5JQH+yoA1YBWCZ8Ey5SEixy/rM7NSjTnLZmZd0cLKNvOKShSHQYBZlykAl3LzOxMxk/IcqAHeloBEjkek5V5nCxeUTRN4QYuQZowzrZcs4Lkf2xwE5ErtOC1o82IbLKJZXepJM0ODyIo=
Message-ID: <d120d5000601091259r46d22f51hf06e93ea4a0ecb33@mail.gmail.com>
Date: Mon, 9 Jan 2006 15:59:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Mouse stalls (again) with 2.6.15-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <9a8748490601091237s57071e57mbd2c4172a0e4dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601091237s57071e57mbd2c4172a0e4dd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 12/21/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 12/21/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > On 12/11/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > > On 12/11/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > >
> > > > > To stop resync attempts do:
> > > > >
> > > > >         echo -n 0 > /sys/bus/serio/devices/serioX/resync_time
> > > > >
> > > > > where serioX is serio port asociated with your mouse.
> > > > >
> > > > This cures the problem nicely with no obvious ill effects with the
> > > > mouse plugged into the KVM...
> > > >
> > >
> > > Jesper,
> > >
> > > Could you please try applying the attached patch to -mm and see if you
> > > still have "resync failed" messages when you don't "echo 0" into
> > > resync_time attribute?
> > >
> > I applied the patch to 2.6.15-rc5-mm3, took out the "echo 0 to
> > resync_time" workaround that I had in rc.local and I no longer see the
> > "resync failed" messages in dmesg.
> > With this patch applied everything seems to be working OK with the
> > mouse attached to the KVM.
> >
>
> Hi Dmitry,
>
> I'm sorry to report that this problem made a comeback :-(
> With 2.6.15-mm2 I again get the mouse stalls and these messages in dmesg :
>

Jesper,

I am sorry, I have not sent updated patch to Andrew yet - I am trying
to figure some ALPS quicks with Frank. I think if you apply that patch
I sent earlier your mouse will work fine.

Sorry about that.

--
Dmitry
