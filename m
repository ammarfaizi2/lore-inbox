Return-Path: <linux-kernel-owner+w=401wt.eu-S1030603AbWLPCd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbWLPCd4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 21:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbWLPCd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 21:33:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2145 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030603AbWLPCdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 21:33:55 -0500
Date: Sat, 16 Dec 2006 03:33:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] include linux/types.h in a bunch of header files for usage with install_headers
Message-ID: <20061216023352.GZ3388@stusta.de>
References: <8bd0f97a0612151808h2aafaf61nf7c29a1cb1962135@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd0f97a0612151808h2aafaf61nf7c29a1cb1962135@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:08:50PM -0500, Mike Frysinger wrote:
> On 12/12/06, Adrian Bunk <bunk@stusta.de> wrote:
> >On Wed, Dec 06, 2006 at 06:03:50PM -0500, Mike Frysinger wrote:
> >> there are a plethora of headers that cannot be included straight due
> >> to the usage of __ types (like __u32) without first including
> >> linux/types.h ... so the question is, should all of these headers be
> >> fixed to properly pull in linux/types.h first or are users expected to
> >> "just know" the correct order of headers ?  in my mind, pretty much
> >> every header is fair game for straight "#include <header>" usage and
> >> requiring a list of headers to be pulled in properly is ignoring the
> >> problem ...
> >
> >Yes, they should all be fixed to #include <linux/types.h>.
> 
> thanks, mondo patch attached :)

Looks good, but after your patch the following headers can be moved from 
unifdef-y to header-y:
  include/linux/atm.h
  include/linux/atmarp.h

> -mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

