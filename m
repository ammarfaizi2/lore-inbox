Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbTJDUf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTJDUf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:35:29 -0400
Received: from b-195-adc53e.lohjanpuhelin.fi ([62.197.173.195]:3458 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S262757AbTJDUfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:35:23 -0400
Date: Sat, 4 Oct 2003 16:35:20 -0400
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LKML strangeness duplicate mail, etc
Message-ID: <20031004203520.GJ1305@mea-ext.zmailer.org>
References: <200310042015.h94KFjVL001113@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310042015.h94KFjVL001113@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is some strange epidemy of qmail related problems around...

On Sat, Oct 04, 2003 at 09:15:45PM +0100, John Bradford wrote:
> Hi,
> 
> I'm seeing some odd behavior apparently from LKML, but it's possible
> that it's not a list problem at all.
> 
> The noticable effect is that mail is duplicated, sometimes
> immediately, sometimes with a delay of a day or more, but something
> else seems wrong as well:

Just earlier today (about 8 hours ago, as it happens) I spotted
duplication at  noos.fr's  qmail system.  I have no real idea of
why it happens, but as it happens with ALL their subscription
addresses, my first order measure I revoked all of their subscriptions.
I did also notify them.

> Just in case the headers are being mangled by secondary-mx.co.uk, I
> have contacted the admin of that server.
> 
> Received: from smtp.noos.fr (nan-smtp-12.noos.net [212.198.2.83])
>         by newton.xela.co.uk (8.11.6/8.11.6) with ESMTP id h94GLZ312486
>         for <john@grabjohn.com>; Sat, 4 Oct 2003 17:21:35 +0100
> Received: (qmail 7531815 invoked by uid 0); 4 Oct 2003 16:21:29 -0000
> Received: (qmail 1637340 invoked by uid 0); 29 Sep 2003 13:22:56 -0000
> Received: from unknown (HELO vger.kernel.org) ([67.72.78.212])
>           (envelope-sender <linux-kernel-owner+danseurfou=40noos.fr@vger.kernel.org>)
>           by 212.198.2.82 (qmail-ldap-1.03) with SMTP
>           for <danseurfou@noos.fr>; 29 Sep 2003 13:22:56 -0000
....

I have seen this same STYLE of qmail-triplets in duplications all
around, and for couple weeks (at least) now.

It definitely has begun to smell like rotten piece of filter code
that has gotten wider use over last couple weeks.

The basic screwup is violation of:
    One shall NEVER use visible "To:" and "Cc:" in message routing.

(and related:  "sendmail -t"  is root of all evil, and should never
have been invented...)

/Matti Aarnio -- one of <postmaster@vger.kernel.org>
