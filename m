Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWHGTBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWHGTBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHGTBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:01:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:59276 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932146AbWHGTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:00:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Msl1dFJCqcP1d/IEXAVdJYpDGSt4bdaOroF9MNIQaGrzwa4KkBIl6XIvxJoj1jhHqDsuXhM/ryl42t/iERHHIxsnT6RLDWUwtImaT3laLgM7bRuzJvBgMwiypNhPy0yHae3ziYg8Ex03cgmfW/a1RdFaV6dcIRDBaNc6lZc/yck=
Message-ID: <d120d5000608071200k3eb2bfd6v166c6bc92f5dcadf@mail.gmail.com>
Date: Mon, 7 Aug 2006 15:00:57 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <b637ec0b0608071147kb8a191bka9d6afe5b5287d08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <b637ec0b0608060848k22af58cbo6f13cee19498c2d2@mail.gmail.com>
	 <20060806120901.ee600a36.akpm@osdl.org>
	 <200608062218.06380.dtor@insightbb.com>
	 <b637ec0b0608071147kb8a191bka9d6afe5b5287d08@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> Hi.
>
> On 8/7/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > On Sunday 06 August 2006 15:09, Andrew Morton wrote:
> > > -tycho kernel: input: PS/2 Mouse as /class/input/input1
> > > -tycho kernel: input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
> > >
> > > That's not so good.
> > >
> > >
> > > Dmitry, do you have anything in there which might have caused that?
> > >
> > > Perhaps hdaps-handle-errors-from-input_register_device.patch is triggering
> > > for some reason.
> >
> > Hmm, I'd be more concerned with i8042-get-rid-of-polling-timer patch...
>
> Bingo! Reverting remove-polling-timer-from-i8042-v2.patch did the
> trick. Now I'm running 2.6.18-rc3-mm2 + hot-fixes :-)
>
> Still interested in dmesg with i8042.debug=1 ?
>

Yes, _with_ the i8042 polling patch applied. Do you have PNP support enabled?

-- 
Dmitry
