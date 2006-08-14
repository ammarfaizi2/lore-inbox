Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWHNT1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWHNT1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWHNT1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:27:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:14504 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932666AbWHNT1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:27:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bfQoGmVb3hGO/dkFAfN73TwQfytd0X7UPeFgXPUQgcPTXqqUU0jryGeYAYfa91WflbNZmQj0yPwpWyUS2YgJ6XvHnJqmE+lYqApi3ML3dLm1hmbr4rB8tgFqpGQRIWhPrcso1p/AuzT8CXCneZoYWQl6Ry+xTL3wwWzSN2U0G1U=
Message-ID: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
Date: Mon, 14 Aug 2006 15:27:52 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: Voluspa <lista1@comhem.se>
Subject: Re: Touchpad problems with latest kernels
Cc: lukesharkey@hotmail.co.uk, linux-kernel@vger.kernel.org,
       gene.heskett@verizon.net, ian.stirling@mauve.plus.com, davej@redhat.com,
       andi@rhlx01.fht-esslingen.de, malattia@linux.it
In-Reply-To: <20060814190959.df449d55.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060814190959.df449d55.lista1@comhem.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Voluspa <lista1@comhem.se> wrote:
>
> On 2006-08-14 13:58:09 Luke Sharkey wrote:
> > While on 2054 it generally works fine, On the latest kernels (2154,
> > 2174 etc.)  I have only to e.g. open a konqueror window for the
> > onscreen pointer to start going funny, and jerking about (As happens on
> > computers with v. low RAM).  I know its not a RAM problem, as a)
> > everything else works fine, there is no slow down of any of the
> > programs I run, only problems with the mouse and b) I have just
> > upgraded from 512 MB of RAM to 1 GB.
> >
> > If I plug in a mouse, the pointer works fine.  Though I would happily
> > use a mouse, this is often inconvenient on a laptop.
> >
> > Do you have any ideas what's wrong?
>
> This is a known problem (and fixed in Windows) with the synaptics touch
> pad. About one year ago I did a web search amounting to something like
> "synaptics rubber band" and found a fixed windows driver. But since
> there is no OS of that kind on this machine, I contacted the developer
> of the synaptics X driver.
>
> We had a discussion (swedish only) in private mail, where I ran the
> driver in debug mode - he no longer had a machine with that hardware.
> Unfortunately I've lost the whole communication due to a voltage frying
> of everything in the mail machine, so can not give any details.
>
> If Peter Österlund still has the e-mails I hereby give full permission
> to disclose a translated copy to anyone interested.
>
> But I think it all came down to Peter not being able to do anything...
> In earlier kernels the issue _seemed_ to lessen if booting with
> i8042.nomux but nowadays that kernel option only gets rid of the 'lost
> sync' messages from the pad that turn up in /var/log/messages
> (Btw, excessive printing of that message Dmitry!)
>

Hmm, have you tried lowering report rate of the synaptics driver
(psmouse.rate=40)? 80 ppsm is quite high and I know some Toshibas have
trouble handling the full rate...

-- 
Dmitry
