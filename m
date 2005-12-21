Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVLUVuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVLUVuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLUVug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:50:36 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:47984 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751166AbVLUVug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:50:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/JEn5F3bl5/8EDVG5V/zoz8UOAwLFOuzxADto/cJfM5Pu6Haw17955ZsL3nir4p1R0CKWu44xubd0l3B9rEXxD619N4y2391s6RttuZ4NaZ9FexRe3gBpdi7mBi4BDevk8THtu2QGrk5wRVHpgC45pqwoZfdD6s/YlHiN5m7lY=
Message-ID: <9a8748490512211350h4225313bx8d97ea21274b62e1@mail.gmail.com>
Date: Wed, 21 Dec 2005 22:50:35 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: Mouse stalls with 2.6.5-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <d120d5000512211259w135b1161l6960fef6e840b983@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
	 <200512111327.40578.dtor_core@ameritech.net>
	 <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
	 <d120d5000512211259w135b1161l6960fef6e840b983@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 12/11/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 12/11/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > > To stop resync attempts do:
> > >
> > >         echo -n 0 > /sys/bus/serio/devices/serioX/resync_time
> > >
> > > where serioX is serio port asociated with your mouse.
> > >
> > This cures the problem nicely with no obvious ill effects with the
> > mouse plugged into the KVM...
> >
>
> Jesper,
>
> Could you please try applying the attached patch to -mm and see if you
> still have "resync failed" messages when you don't "echo 0" into
> resync_time attribute?
>
I applied the patch to 2.6.15-rc5-mm3, took out the "echo 0 to
resync_time" workaround that I had in rc.local and I no longer see the
"resync failed" messages in dmesg.
With this patch applied everything seems to be working OK with the
mouse attached to the KVM.


> Thank you in advance,
>
Thank /you/ for fixing it.  :-)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
