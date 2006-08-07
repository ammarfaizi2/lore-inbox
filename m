Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWHGSrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWHGSrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHGSrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:47:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:49176 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932307AbWHGSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:47:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i5uob/Ttp/XJpx0WocdWUhiv4RtGnAZ1I6f43i/lIW3oAXHD2qP0746WmNhuRTjEMDwGv1aXutFemFngWuiMLNXVDFH42Yk2SCWgFAQqvZRz8TKb08zrHKL15OY7vLJGwofl7EiGvW9GCRYxLzR9UobNnwMs2GFgGYbmsWTnaoQ=
Message-ID: <b637ec0b0608071147kb8a191bka9d6afe5b5287d08@mail.gmail.com>
Date: Mon, 7 Aug 2006 20:47:00 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200608062218.06380.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <b637ec0b0608060848k22af58cbo6f13cee19498c2d2@mail.gmail.com>
	 <20060806120901.ee600a36.akpm@osdl.org>
	 <200608062218.06380.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 8/7/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Sunday 06 August 2006 15:09, Andrew Morton wrote:
> > -tycho kernel: input: PS/2 Mouse as /class/input/input1
> > -tycho kernel: input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
> >
> > That's not so good.
> >
> >
> > Dmitry, do you have anything in there which might have caused that?
> >
> > Perhaps hdaps-handle-errors-from-input_register_device.patch is triggering
> > for some reason.
>
> Hmm, I'd be more concerned with i8042-get-rid-of-polling-timer patch...

Bingo! Reverting remove-polling-timer-from-i8042-v2.patch did the
trick. Now I'm running 2.6.18-rc3-mm2 + hot-fixes :-)

Still interested in dmesg with i8042.debug=1 ?

Ciao.
Fabio


> Anyway, can I have dmesg from boot with i8042.debug=1, please? Make sure
> you have big log biffer.
>
> --
> Dmitry
>
