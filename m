Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992711AbWJTTOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992711AbWJTTOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992712AbWJTTOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:14:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18562 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992711AbWJTTOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:14:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IpGSdN5p8vQGjilBEwf7lhLbwfHGDAcP7OYWvFmiMFNqOci3mRBNviujQV9BmEEOYjhca9it6yofFBHTIQIb3KDW5m8hf8ZeUrJGnO+7ZVkUxMnBtTWniXJZOjmenCZma7DsnL0jK7w6ZQRgp7IWItymj6OhGwToLRmWXMuyruI=
Message-ID: <d120d5000610201213v3ee2144cp4642f1812dfe7884@mail.gmail.com>
Date: Fri, 20 Oct 2006 15:13:59 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: various laptop nagles - any suggestions? (note: 2.6.19-rc2-mm1 but applies to multiple kernels)
Cc: teunis <teunis@wintersgift.com>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20061020110746.0db17489.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4537A25D.6070205@wintersgift.com>
	 <20061019194157.1ed094b9.akpm@osdl.org>
	 <4538F9AD.8000806@wintersgift.com>
	 <20061020110746.0db17489.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 20 Oct 2006 09:30:37 -0700
> teunis <teunis@wintersgift.com> wrote:
>
> >
>
> Please don't play with the Cc:s!  Just do reply-to-all, thanks.
>
> > Andrew Morton wrote:
> > > On Thu, 19 Oct 2006 09:05:49 -0700
> > > teunis <teunis@wintersgift.com> wrote:
> > >
> > >> -----BEGIN PGP SIGNED MESSAGE-----
> > >> Hash: SHA1
> > >>
> > >> Setting the internal clock to 100 Hz stablizes the laptop - and the
> > >> synaptics touchpad stops "crashing"  (when "crashed" the pad reads out
> > >> all kinds of seemingly random values).   I would suspect the driver
> > >> needs adjusting for the variable clock.   Also - it's definitely nicer
> > >> on the laptop power use as far as I can tell - should this be in the
> > >> documentation?
> > >
> > > So you're saying that CONFIG_NO_HZ breaks the touchpad?
> >
> > yes.  At least for Acer Travelmate 8000 and HP nx6310 and HP nx7400.
> > Other than the touchpad - there is not a lot of common hardware between
> > these units.   The readout becomes highly unreliable.   (in X it starts
> > jumping around - it SORT OF resembles the output)
> >
> > My suspicion is a timing problem in the synaptic USB driver
>
> OK, that's going to be hard to fix and it'd be awkward (and unpopular) to
> make inclusion of the dynamic-ticks feature dependent on fixing this.
> (Then again, it'd get Ingo into device drivers ;))
>

I wonder if the problem is with the in-kernel synaptics driver or with
X (itself or synaptics driver in it). Does the touchpad misbehaves
when you using GPM on text console? What about when you using legacy
mouse driver (as opposed to synaptics) in X?

-- 
Dmitry
