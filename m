Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWGCWLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWGCWLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWGCWLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:11:05 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:36499 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751103AbWGCWLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:11:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZTuIe6yH2guXdzKew3F8JpuVOl6lK0wPuYpGJdkTT41dT3VXMGI8a+6hFI+yYkSA37jLao8m+vF9oP70z/qm9z0sqIACDnNYE4SahVtbv2PkFZTaBz26xupEZRemZWWo8eABcKuTESc9Rrdrq12w8tdAw76/vKzp/bBhYo7aM0=
Message-ID: <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
Date: Mon, 3 Jul 2006 18:11:03 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Alon Bar-Lev" <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060703214509.GA5629@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com>
	 <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
	 <44A95F12.8080208@gmail.com>
	 <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/06, Greg KH <greg@kroah.com> wrote:
> A: No.
> Q: Should I include quotations after my reply?
>
> On Mon, Jul 03, 2006 at 04:53:43PM -0400, Daniel Bonekeeper wrote:
> > hahahaha I wish I could... well, you are _always_ welcome to donate me
> > yours ! =P
> > I'll try more later to get one of those readers...
> >
> > Reading Greg's comment, now I'm in doubt if this should really be in
> > kernel mode or at userspace. Since there is no standard (AFAIK) for
> > those readers, how should it be done ?
>
> It all depends on what you want the userspace interface to be.
>

That's one problem: I don't want to create one more userspace
interface for that. I suppose that all the hundreds of fingerprint
readers that ships with a SDK have their own way of doing that.. that
looks awfull to me, even though I believe that currently there isn't
any uniform way of working with fingerprint readers... shouldn't we
have a way to classify devices ? For example, if I want to list all
the printers connected via USB (supposing that we have more than one),
I should be able to request that information from somewhere
(/dev/usb/printers/* ?) I suppose that different fingerprint readers
works with different resolutions... we should be able to have an
unified interface that could tell the userspace the capabilities of
each fingerprint device (the area size of the scanner, resolution,
etc)... I think that applies for a lot of devices, not just
fingerprint readers. Probably there is already something like that.

> > Another thing: where can I find documentation about the USB
> > architecture ?
>
> www.usb.org for the USB specs.  See the kernel built-in documentation
> for a full document on how the Linux USB layer works.

Thanks... UTFG for me. #)

> > For example, I suppose that some (or all) USB devices may have DMA
> > capabilities... how is this done ?
>
> Heh, no, USB can't do DMA at all.  Why would you think they could?  It's
> a serial bus that just streams data across it at relativly slow speeds.
>

Well.. even though I didn't know how and was a bit suspicious, I used
to believe that USB devices could do DMA because I heard some time ago
about "the danger of USB devices that could do DMA and have total
access over the OS"... something on bugtraq or securityfocus...
talking about USB and FireWire devices and how they could be used to
"inject" stuff on the system's memory and take it over... but I guess
it only applies to firewire (even though USB was clearly mentioned).
Reviewing it, it definitely applies just for firewire stuff.

http://www.csoonline.com/read/050106/ipods.html


> thanks,
>
> greg k-h
>


-- 
What this world needs is a good five-dollar plasma weapon.
