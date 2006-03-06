Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWCFVOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWCFVOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWCFVOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:14:41 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:61879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbWCFVOk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:14:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kTPCPHlHImzrHAMmQP37Q5WRGN4OIQrj6cb3Fsml8qNvMTJ7RGyEgoKFWZl2X0Vrthzt7ea2qicn4RpkuMpzEKtejWByIR2RxljTmi/SS8NpU4hbCEbOrf/a00WBj5BmhcWbqdT2aUeHY8PNxHBbSW3BHB/d3KOimFOlAFVWIN0=
Message-ID: <9a8748490603061314o548f2345k6fecd812ad19597a@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:14:39 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>
In-Reply-To: <20060306203319.GR4595@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062124.42223.jesper.juhl@gmail.com>
	 <20060306203036.GQ4595@suse.de> <20060306203319.GR4595@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Jens Axboe <axboe@suse.de> wrote:
<snip>
>
> This is the one:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114041855331295&w=2
>
> Also an -mm report, btw. Does this reproduce with 2.6.16-rcX latest?
>

I just build and booted a2.6.16-rc5-git8 with the same config that I
used for the -mm kernel and the problem did not manifest itself there.
So it seems that mainline is fine but we need to find the bug before
it propagates from mm to mainline.

I'll test a -mm kernel without slab debug/poison now to see it it goes Oops.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
