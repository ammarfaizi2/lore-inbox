Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVBWRxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVBWRxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVBWRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:53:12 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:56052 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261514AbVBWRxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:53:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TIhvV2Sp4tAFQSa28AdZiWWOyJR2xKEAV1bNHJc/jrrDhBYBwBDi8wqDFLhzpuT/bjq/PMS/Iimlyu9GMlFGDvFrKrmn7av/fVSnebr6mTcG6/PdkXG2/tRocbT7UuquDEzURaQz2ETobxUiRW2iFBM52E6RZAbCjQRfF7fnX4M=
Message-ID: <d120d50005022308536d29dab7@mail.gmail.com>
Date: Wed, 23 Feb 2005 11:53:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Nils Kalchhauser <n.kalchhauser@vollwerbung.at>
Subject: Re: mouse still losing sync and thus jumping around
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <421CAF7D.9080004@vollwerbung.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <421C83A2.9040502@vollwerbung.at>
	 <d120d50005022306177069ffbe@mail.gmail.com>
	 <421CAF7D.9080004@vollwerbung.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 17:29:49 +0100, Nils Kalchhauser
<n.kalchhauser@vollwerbung.at> wrote:
> Dmitry Torokhov wrote:
> > On Wed, 23 Feb 2005 14:22:42 +0100, Nils Kalchhauser
> > There were 2 versions of the psmouse-resend patch, the first one was
> > indeed producing worse results, the second one should work better.
> > Could you please try grabbing the patch against 2.6.10 from here:
> >
> > http://www.geocities.com/dt_or/input/2_6_10/
> >
> > and letting me know if it gives better results.
> 
> sorry for not realising that there was a newer patch. I tried that one
> now and indeed it seems a lot better. I did not have any lost sync
> message for about an hour but then the mouse started jumping again. and

Was it clicking around or just the movement was jerky?

> it seems to me like it is connected to disk activity... is that possible?

Yes, It usually happens either under high load, when mouse interrupts are
significantly delayed. Or sometimes it happen when applications poll
battey status and on some boxes it takes pretty long time. And because
it is usually the same chip that serves keyboard/mouse it again delays
mouse interrupts.

Btw, what kind of laptop/touchpad is that?

-- 
Dmitry
