Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSG2MRS>; Mon, 29 Jul 2002 08:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSG2MRS>; Mon, 29 Jul 2002 08:17:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25871 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316217AbSG2MRN>; Mon, 29 Jul 2002 08:17:13 -0400
Message-ID: <3D4531EA.9030103@evision.ag>
Date: Mon, 29 Jul 2002 14:15:38 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] partition fix
References: <UTC200207291135.g6TBZAZ15815.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>     > The patch below does two things:
>     > 
>     > (i) fixes a small bug in the new partition code
>     > This is the final chunk s/n/slot/. I'll refrain from giving a vi script.
>     > This is uncontroversial.
>     > 
>     > (ii) removes ancient garbage concerning disk managers
>     > This may well be controversial.
> 
>     The disk managers where kludgy garbage in first place.
>     And nowadays I agree with you: It's not worth to dragg it around.
> 
> Indeed. But the change will generate some noise.
> People will get assigned a somewhat different disk geometry
> in many cases and will need some education (or a new fdisk)
> to keep them from worrying.

I'm simply thinking only about the EZ disk remapper in IDE code, which
is able to map access behind physical disk size. Take a look at
do_ide_request() please. It's time to let it go. If someone still needs
to access this kind of disk, he can still do -> /dev/loop is providing
a mechanism for sector remapping.



