Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933064AbWKMVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064AbWKMVYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWKMVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:24:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:3707 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933065AbWKMVYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:24:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q0wLCmIyuPGB+mfXi55b2ZtfYUZlhXKxO17tPlgjYXOkCws1ytK2x0iIzrdiZ3qLJc1M1fk/jaY9hH35d1mHoCDRPHq3/nJHaANndv9wq1Q4foRoqEpR7X3p2B8jUwU5mZsEcq6EXNyd/xtkoNEwLRhVqaEhpJonP6fLvarFpK8=
Message-ID: <d120d5000611131324q3c124ae9h969adc18e35ee350@mail.gmail.com>
Date: Mon, 13 Nov 2006 16:24:41 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Luca Tettamanti" <kronos.it@gmail.com>
Subject: Re: [PATCH] atkbd: disable spurious ACK/NAK warning on panic
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20061113204340.GA25557@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061113204340.GA25557@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Luca Tettamanti <kronos.it@gmail.com> wrote:
> After the panic() message has been printed kernel may blink keyboard
> leds to signal the abnormal condition.
> atkbd warns that "Some program might be trying access hardware directly"
> at every blink, scrolling the useful text out of the screen.
> Avoid printing the warning when oops_in_progress is set in order to
> preserve the panic message.
>

Hi Luca,

Current input git tree already has code in i8042 supressing extra ACKs
caused by palic blinks; as soon as Linus pulls from me you should not
see these messages anymore.

-- 
Dmitry
