Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDXOpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDXOpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWDXOpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:45:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:7377 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750775AbWDXOpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:45:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OloTfHoErppvuNYpFMVGoIhOJFPnvfkRpIi3SLohS4/jh8xe0FMCMwMiS92NB5+7/5SGSIutrXAgQ/NJ+K+c2MLFNz6TsLiw4XWBBDgavYlaznOjAbG1Atta2OAORLY0MaG42en++BuVVrQ6/wrKEePIdRPRsZ8tBo9EQEDH9yU=
Message-ID: <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
Date: Mon, 24 Apr 2006 10:45:31 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Cc: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Richard Purdie" <rpurdie@rpsys.net>, "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <20060419202421.GA24318@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060419195356.GA24122@srcf.ucam.org>
	 <20060419200447.GA2459@isilmar.linta.de>
	 <20060419202421.GA24318@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Apr 19, 2006 at 10:04:47PM +0200, Dominik Brodowski wrote:
> > On Wed, Apr 19, 2006 at 08:53:58PM +0100, Matthew Garrett wrote:
> > > +++ a/include/linux/input.h 2006-04-19 20:49:18 +0100
> > > @@ -344,6 +344,7 @@
> > >  #define KEY_FORWARDMAIL            233
> > >  #define KEY_SAVE           234
> > >  #define KEY_DOCUMENTS              235
> > > +#define KEY_LID                    237
> >
> > What about 236?
>
> I sent a patch last month that uses 236 for KEY_BATTERY, so decided not
> to conflict with it.
>

Yes, I still need to apply it.

Matthew, I would recommend not adding KEY_LID but using one of the
switch codes (SW_0?) for the lid.

Richard, on your handhelds what switch would be most similar to
notebook's lid? Should we alias one of the switches to SW_LID?

--
Dmitry
