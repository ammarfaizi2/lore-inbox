Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273172AbRIJC6t>; Sun, 9 Sep 2001 22:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273173AbRIJC6j>; Sun, 9 Sep 2001 22:58:39 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:38084 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S273172AbRIJC6b>; Sun, 9 Sep 2001 22:58:31 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: John Ripley <jripley@riohome.com>, linux-kernel@vger.kernel.org,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Date: Sun, 9 Sep 2001 19:58:27 -0700 (PDT)
Subject: Re: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <20010910023641Z16066-26183+701@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109091957120.31268-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if sectors full of zeros are really that common then they should never be
swapped out, just a new page allocated and zeroed when it would be swapped
back in. Even better then combining all of them into one block on disk.

David Lang

 On Mon, 10 Sep 2001, Daniel Phillips wrote:

> Date: Mon, 10 Sep 2001 04:43:53 +0200
> From: Daniel Phillips <phillips@bonn-fries.net>
> To: John Ripley <jripley@riohome.com>, linux-kernel@vger.kernel.org
> Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
> Subject: Re: COW fs (Re: Editing-in-place of a large file)
>
> On September 9, 2001 06:30 pm, John Ripley wrote:
> > Interesting results for the swap partitions. Probably full of zeros.
>
> It doesn't make a lot of sense to spend 30-35% of your swap bandwidth
> swapping zeros in and out, does it?
>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
