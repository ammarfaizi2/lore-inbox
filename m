Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSEUU61>; Tue, 21 May 2002 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSEUU60>; Tue, 21 May 2002 16:58:26 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:55558 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S316594AbSEUU6Z>; Tue, 21 May 2002 16:58:25 -0400
Date: Tue, 21 May 2002 16:58:26 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel ?
Message-ID: <20020521165826.H2645@sventech.com>
In-Reply-To: <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com> <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com> <20020521195925.GA2623@kroah.com> <5.1.0.14.2.20020521133408.068d2ef8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002, Maksim (Max) Krasnyanskiy <maxk@qualcomm.com> wrote:
> 
> > > So basically I vote for usb-uhci. However some things will have to be
> > > fixed. We (Bluetooth folks) have couple
> > > of devices that refuse to work with usb-uhci (I didn't test the latest
> > > usb-uhci though).
> >
> >Sorry for the confusion, but both usb-uhci.c and uhci.c will be deleted 
> >anyway :)
> I thought that usb-uhci-hcd and uhci-hcd are direct derivatives of usb-uhci 
> and uhci
> (ie just minor API changes). And therefor perform exactly the same.

I wouldn't consider it a minor API change, but theoretically they should
perform identically. Since some changes were non trivial, I wouldn't
guarantee that they behave identically :)

However, I'm not sure that's all that interesting. The code is a
straight enough port over that if there are bugs, they'll be there in
both versions, except for some trivial porting mistakes. Those are easy
to find and easy to fix normally.

The other kinds of bugs, like fundamental design flaws or bugs that
have always been there, are more interesting and likely to be in both.

IMO, I think testing with usb-uhci.c and uhci.c is still useful, but
testing with the -hcd variants is the most ideal since that will be the
final code base.

JE

