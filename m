Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313555AbSDQLXm>; Wed, 17 Apr 2002 07:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313560AbSDQLXl>; Wed, 17 Apr 2002 07:23:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36357 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313555AbSDQLXl>; Wed, 17 Apr 2002 07:23:41 -0400
Message-ID: <3CBD4CA7.6090003@evision-ventures.com>
Date: Wed, 17 Apr 2002 12:21:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Stephen Samuel <samuel@bcgreen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: More than 10 IDE interfaces
In-Reply-To: <20020411040845.GE14801@dark.x.dtu.dk> <3CB53D70.5070100@evision-ventures.com> <3CBC0FA1.8070907@bcgreen.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Samuel wrote:
> It might be trowing bad money after good to do it, but why
> not just put together a simple translation table.
> 
> rather than
> drivenum=(driveletter - 'a')
> and
> driveletter=(drivenum+'a')
> 
> have translation tables, so that
>     drivenum= chartodrivenum[driveletter]
>    and
>     driveletter= drivenumtoletter[drivenum]
> If you're willing to map (almost) all of the printable
> characters, you could get 46 controllers and 92 drives
> (I'd refuse to map  ', ", \  or space)
> 
> 
> You'd still be limited to one character, but it would, at least
> make it easy to have 26 controllers and 52 drives  (and that's
> just using upper and lower case characters!)

Hmm this propasal is not without reaons but the main obstacle
is currently just the option parsing code in ide. At some
point in time I just intend to rewrite it and to support
namings along the way of /dev/hdXX, where XX are simply digits.
The old names will be preserved as "backwards compatibility".

OK?
If you wish you could of course look in to this yourself, since
it's not *that* difficult. I would be really glad if someone did this.

