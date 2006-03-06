Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWCFV2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWCFV2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWCFV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:28:50 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:46453 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932354AbWCFV2t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:28:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HsdvLqZOnE1MhXwsg7TXHo5iJHtYGcjMZ9by53yZgnXMB6B/FQJS/TrSgXWVLmVlArQs2VnvzpKJzXeL/UDYa1G8T+vK7WFYBudOMRntbdhlOCjE9fCPogmUC4pasdbsSzFldADPrHBX8tCnd5pxQsEYHbOkl5CDJ0oCG+sL5jQ=
Message-ID: <6e0cfd1d0603061328n6a162fefo5e53fe74657b2a41@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:28:47 +0100
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Cornelia Huck" <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] s390 - fix match in ccw modalias
Cc: "Bastian Blank" <bastian@waldi.eu.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>
In-Reply-To: <20060306084639.05bd7a9b@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306020024.GA25620@wavehammer.waldi.eu.org>
	 <20060306084639.05bd7a9b@gondolin.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Mon, 6 Mar 2006 03:00:24 +0100
> Bastian Blank <bastian@waldi.eu.org> wrote:
>
> > diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> > index be97caf..c164b23 100644
> > --- a/scripts/mod/file2alias.c
> > +++ b/scripts/mod/file2alias.c
> > @@ -246,7 +246,7 @@ static int do_ccw_entry(const char *file
> >           id->cu_model);
> >       ADD(alias, "dt", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
> >           id->dev_type);
> > -     ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
> > +     ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_MODEL,
> >           id->dev_model);
> >       return 1;
> >  }
>
> Patch makes sense to me.
>
> > Martin: can you please push them through for 2.6.16? It breaks automatic
> > loading of any dasd module.
>
> I don't know whether Martin is operational this week, but I'd second an
> inclusion into 2.6.16.

No really operational since I'm in Seattle. I'm watching lkml though. The patch
makes much sense to me as well and if Cornelia doesn't object the patch
should get integrated.

--
blue skies,
  Martin
