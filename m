Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWBAP4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWBAP4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBAP4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:56:22 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:38455 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161105AbWBAP4U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:56:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iEa83EYc9Ri/C+W2Lxl5n+qzD+708IIBVpRq9X1qEnnmWRDPbwz3c5PSChursLPWr+zhI3crZ38NwCR7ZG4ZZ60knJQJujym1pE9BNiKFKffynq0kOr7J8d9fmxz6i4G54v0JXukqXiKvjisxqYkij0bu9/JvqtrQKVdK2ytfTo=
Message-ID: <58cb370e0602010756r3973fde7v387c7529b2bd80cd@mail.gmail.com>
Date: Wed, 1 Feb 2006 16:56:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Denis Vlasenko <vda@ilport.com.ua>, Oliver Neukum <oliver@neukum.org>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, acahalan@gmail.com
In-Reply-To: <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
	 <200601311333.36000.oliver@neukum.org>
	 <200601311444.47199.vda@ilport.com.ua>
	 <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> > If it's /dev/cdrw, then it's /dev/cdrw, not '1,0,0'.
> >> >
> >> > Should we make a poll ?
>
> select(), poll(), epoll(), anyone? (SCNR)
>
> >Do we need to expose IDE master/slave, primary/secondary concepts in Linux?
> >
> AFAICS, we do. hda is always primary slave, etc. With the SCSI layer it's

Ehm, primary master and it is not true if you are using host drivers as modules.

Moreover providing ordering by IDE driver has been nightmare to maintain
and can't be done correctly for 100% weird cases.

> (surprisingly) the other way round, sda just happens to be the first disk
> inserted (SCA, USB, etc.)

Which is much saner approach from developers' POV.

Bartlomiej
