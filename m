Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWBTJpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWBTJpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWBTJpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:45:05 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:13910 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932408AbWBTJpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:45:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LUTzlKovowm8kfuI714LBg4g5J0Aub0e4ZuoVTTa22wowhE+Zp5IeSesHqNMRhJ89+b4Yh5y5qT2VeROcHRCF9vdbVhxfHhyvk2Y0CB4eHQUuN9vCv4hdJCe9JxTaKxX09apBWkMkgiuy9nMwXQ1lYK4U2j3RSHTdFVsFGxRbz8=
Message-ID: <81b0412b0602200145r77e99ddbvea55ce9aff07b575@mail.gmail.com>
Date: Mon, 20 Feb 2006 10:45:02 +0100
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Work around asus_acpi driver oopses on Samsung P30s and the like due to the ACPI implicit return
Cc: "Alex Riesen" <fork0@users.sourceforge.net>,
       acpi-devel@lists.sourceforge.net, torvalds@osdl.org, mail@hboeck.de,
       len.brown@intel.com, Greek0@gmx.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060219211852.05d08f55.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
	 <20051222174226.GB20051@hell.org.pl>
	 <20060219125258.GB6041@steel.home>
	 <20060219211852.05d08f55.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Andrew Morton <akpm@osdl.org> wrote:
> Alex Riesen <fork0@users.sourceforge.net> wrote:
> >
> > FWIW, I need the patch below to stop ACPI freezing at boot on Asus S1300N.
> > There is a BIOS update from Asus, but no mention of any fixes in ACPI,
> > so as I have no means to backup the BIOS in case something goes wrong
> > I didn't do the update.
>
> I think it'd be worth trying the update anyway please.  Normally those
> updating programs are pretty careful to not give you a dead box.

You think? ... Still, it'll have to wait till the next weekend. I really
cannot afford a "dead box" midweek.

> > I found out (by putting printks in the initialization code) that a
> > call to INI (whatever it is) of VGA_ (whatever this is) immediately
> > freezes the notebook and the fan goes on shortly afterwards.
> >
>
> Is this a recent problem, or did earlier 2.6.x kernels also fail?

Yes. I think I got the notebook around 2.6.9, and it already had the problem.
I don't remember what I did back than, probably run it with ACPI disabled,
or maybe I made that workaround immediately (there were some sound
problems without ACPI, I recall).
