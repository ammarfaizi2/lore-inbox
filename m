Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbSIWVbA>; Mon, 23 Sep 2002 17:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSIWV3d>; Mon, 23 Sep 2002 17:29:33 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:60342 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261449AbSIWV3J>;
	Mon, 23 Sep 2002 17:29:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Mon, 23 Sep 2002 23:31:13 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, dmo@osdl.org, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <15759.26918.381273.951266@napali.hpl.hp.com> <20020923.135708.10698522.davem@redhat.com> <15759.34428.608321.969391@napali.hpl.hp.com>
In-Reply-To: <15759.34428.608321.969391@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tanS-0003cl-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 23:24, David Mosberger wrote:
> >>>>> On Mon, 23 Sep 2002 13:57:08 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:
> 
>   >> On many platforms, two consequetive __raw_writel()'s might even
>   >> combine to an atomic 64-bit store to PCI space. :-)
> 
> Yes, but that's no guarantee.
> 
>   >> I don't think the proposed 32-bit behavior is off the mark, and
>   >> anyways x86 can actually make the 64-bit store I believe if it
>   >> wants at least on more recent processors.
> 
> Surely we wouldn't want to define a new API that can't be supported on
> all 32-bit platforms, no?  Perhaps writeq_nonatomic()?

Why attempt to write 8 bytes on ia32 when only 4 are needed?

-- 
Daniel
