Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWG1M5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWG1M5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWG1M5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:57:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:25211 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751368AbWG1M5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:57:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IKeRlbXec6EcPYL/ixrqYeikFNg0Q6T8HudzbZ7wySU7PVLMgy9+sajYeBo7g6zAtVDkmcFwW4HIBY6YyV1poD3229cyMJCOmIiDJdT/z4YfU9oOPdQ/CAoj11gAqx2YbcVk81kynGr1gUSbM2baHccJK7tIRS5iK5GJZSMtUTM=
Message-ID: <d120d5000607280557w2aa476b2y45d8cfc866296adf@mail.gmail.com>
Date: Fri, 28 Jul 2006 08:57:31 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [RFC/RFT] Remove polling timer from i8042
Cc: linux-kernel@vger.kernel.org, "Dave Jones" <davej@redhat.com>
In-Reply-To: <20060727234423.GC4907@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607270029.05066.dtor@insightbb.com>
	 <20060727234423.GC4907@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Jul 27, 2006 at 12:29:04AM -0400, Dmitry Torokhov wrote:
> > Hi,
> >
> > OK, I had it in works for quite some time and Dave's talk in Ottawa
> > made me finish it ;)
>
> Good work.
>
> However I believe you need to test the AUX IRQ in this case before you
> use it, otherwise you'll have a lot of people with non-working keyboards
> (the input queue is shared), and probably also non-working PCI cards
> (BIOSes like to assign IRQ12 to PCI if no mouse is detected by the
> BIOS).
>

What do you mean by testing AUX IRQ? Use I8042_CMD_AUX_LOOP to see if
interrupt fires off? The new code releases IRQ if it can't find a
working AUX port...

> You'll see whether this test is necessary if a lot of people report
> problems without i8042.noaux.
>
> That can only be seen after extensive testing on a lot of machines,
> though. Fortunately 386's and 486's are more or less extinct now, and
> with them a lot of the weirder keyboard controllers.
>

I think I will forward the patch to Andrew and we will see how bad it
is. It works on couple of boxes here but I don't have a lot of
hardware to test on...

-- 
Dmitry
