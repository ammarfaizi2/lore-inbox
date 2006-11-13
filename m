Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933073AbWKMVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073AbWKMVjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWKMVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:39:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:32750 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933073AbWKMVjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:39:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jJdYQpQL41rgLf/2OjTFpXnHE19QGFekHTomfOBcbzDR0NrzMIbQNf2cCaWFWpCTbL1J+R9Hliyr1vwss1tzik1K/+x415aRU4clLGiD9HN967rlCoSy8Rl20HbTGNoVnozi52ac/U1TpSm1VKHMP9CPTBZmbz4wfCQVJWxlIgU=
Message-ID: <68676e00611131339l5b0dc9a2rc8e0b590aca6c162@mail.gmail.com>
Date: Mon, 13 Nov 2006 22:39:12 +0100
From: "Luca Tettamanti" <kronos.it@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] atkbd: disable spurious ACK/NAK warning on panic
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000611131324q3c124ae9h969adc18e35ee350@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061113204340.GA25557@dreamland.darkstar.lan>
	 <d120d5000611131324q3c124ae9h969adc18e35ee350@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
Hi,

> On 11/13/06, Luca Tettamanti <kronos.it@gmail.com> wrote:
> > After the panic() message has been printed kernel may blink keyboard
> > leds to signal the abnormal condition.
> > atkbd warns that "Some program might be trying access hardware directly"
> > at every blink, scrolling the useful text out of the screen.
> > Avoid printing the warning when oops_in_progress is set in order to
> > preserve the panic message.
>
> Current input git tree already has code in i8042 suppressing extra ACKs
> caused by panic blinks; as soon as Linus pulls from me you should not
> see these messages anymore.

Great, thanks.

Luca
