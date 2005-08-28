Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVH1FaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVH1FaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 01:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVH1FaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 01:30:15 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:32818 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751105AbVH1FaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 01:30:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k4ZOmzDd02eL99TkugRNReQUQdl2NxoTA2FNBCDQG8SK8wna7rXYBuoW95utemrpkk28dMLYMaeQDvpl25flSbitV2xG83FbaiIGxd1ZZk1Zy/aUnqO8x48l3YqrqkOeBae4ow/sjfjiVrffpCinaO1f/FgJJ62JMAtuAPZlqHE=
Message-ID: <253818670508272230540fa9dd@mail.gmail.com>
Date: Sun, 28 Aug 2005 01:30:12 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Cc: Jens Axboe <axboe@suse.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jon Escombe <lists@dresco.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
In-Reply-To: <20050827123408.GD1109@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <253818670508250708a9075a0@mail.gmail.com>
	 <58cb370e0508250859701ea571@mail.gmail.com>
	 <253818670508252204b22e8c2@mail.gmail.com>
	 <20050826065515.GQ4018@suse.de>
	 <20050827123408.GD1109@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 8/27/05, Pavel Machek <pavel@suse.cz> wrote: 
> Well, with my power-managment hat on:
> 
> we probably want "freeze" functionality to be generic; it makes sense
> for other devices, too.
> 
> "My battery is so low I can not use wifi any more" => userspace
> freezes wifi.
> 
> Now, having this kind of timeout in all the cases looks pretty ugly to my eyes.

Thing is the freeze attribute hasn't got much to do with power
management, this is just to freeze the queue, and park the drive head
ASAP (preferably with the unload immediate command supported by new
drives) in order to protect the drive in an impact. Unload immediate
doesn't even stop spinning the drive, so little power is saved.

Maybe a suspend attribute would be a good idea for something along the
lines of what you have in mind? A enable/disable attribute would
definitely make sense for that application.

I suppose renaming the attribute to "ramming_speed" or
"brace_for_impact", might make the purpose more clear ;).

Thanks,
Yani
