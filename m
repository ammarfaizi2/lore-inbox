Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272299AbRIKGos>; Tue, 11 Sep 2001 02:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272304AbRIKGoi>; Tue, 11 Sep 2001 02:44:38 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:59545 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S272299AbRIKGo0>; Tue, 11 Sep 2001 02:44:26 -0400
Message-ID: <014801c13a8c$7e98f370$2a3147ab@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "Rik van Riel" <riel@conectiva.com.br>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>,
        "Andreas Dilger" <adilger@turbolabs.com>,
        "Andrea Arcangeli" <andrea@suse.de>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109102151581.30234-100000@imladris.rielhome.conectiva>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 23:39:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not about the absolute size of meta data..it's about having limited
cache size.  Whatever you read ahead, as long as it doesn't do good it
wastes space and pushes (more) useful data out of the cache, and thus what
you gain in the readahead will be outweighted by further re-reading.

readahead is good, but doing it too aggressively is not.

----- Original Message -----
From: "Rik van Riel" <riel@conectiva.com.br>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>; "Andreas Dilger"
<adilger@turbolabs.com>; "Andrea Arcangeli" <andrea@suse.de>; "Kernel
Mailing List" <linux-kernel@vger.kernel.org>
Sent: Monday, September 10, 2001 5:53 PM
Subject: Re: linux-2.4.10-pre5


> On Mon, 10 Sep 2001, Linus Torvalds wrote:
> > > On September 11, 2001 12:39 am, Rik van Riel wrote:
>
> > > > This suggests we may want to do agressive readahead on the
> > > > inode blocks.
>
> > So it' snot just about preloading. It's also about knowing about access
> > patterns beforehand - something that the kernel really cannot do.
> >
> > Pre-loading your cache always depends on some limited portion of
> > prescience.
>
> OTOH, agressively pre-loading metadata should be ok in a lot
> of cases, because metadata is very small, but wastes about
> half of our disk time because of the seeks ...
>
> regards,
>
> Rik
> --
> IA64: a worthy successor to i860.
>
> http://www.surriel.com/ http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

