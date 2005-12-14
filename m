Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVLNQcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVLNQcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVLNQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:32:54 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:22984 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964833AbVLNQcx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:32:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+n88kKbfgIpR4JtfEfVOliBNlPK33b6zOIVTaEgEtYcW2QSfLaslZ8dyvnBR1ZAxX6mGlRZIUsYVySnVr21Sm1isHcn6ezI9E6KK85uWU7VobKugXOnJXxCmS8+0qbkrjOAye5L98IZ6dSky6xIikVyEy9Gd586oziFWP9Nruw=
Message-ID: <41840b750512140832r2be9317akcc9d661e7810cf0f@mail.gmail.com>
Date: Wed, 14 Dec 2005 18:32:51 +0200
From: Shem Multinymous <multinymous@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tp_smapi conflict with IDE, hdaps
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>,
       Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
In-Reply-To: <1134490575.11732.104.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <1134488305.11732.74.camel@localhost.localdomain>
	 <41840b750512130804s32fe543xa11933f681973281@mail.gmail.com>
	 <1134490575.11732.104.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> But the ACPI DSDT is OS independant in theory and in practice to a fair
> extent. It can't make assumptions about windows drivers.

The IDE issue is moot in light of SET_STREAMING, but just for the
record: the preinstalled Windows on this ThinkPad uses Microsoft's
default IDE driver and Intel's default 82801FBM driver, so it doesn't
look like it's doing SMAPI-specific synchronization.


> Its probably easier to write than go find one
>
> I mean you need
>
> tp_hw_init() {
[code snipped]

Oh, thanks! That's far less voodoo than I feared.

I'll coordinate things with Robert Love (hdaps maintainer).

  Shem
