Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAEMAd>; Fri, 5 Jan 2001 07:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRAEMAO>; Fri, 5 Jan 2001 07:00:14 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:57472 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129675AbRAEMAJ>; Fri, 5 Jan 2001 07:00:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010104224946.C1290@redhat.com> 
In-Reply-To: <20010104224946.C1290@redhat.com>  <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> 
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2001 11:58:56 +0000
Message-ID: <1628.978695936@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sct@redhat.com said:
> In what way?  A root fs readonly mount is usually designed to prevent
                                            ^^^^^^^
> the filesystem from being stomped on during the initial boot so that
> fsck can run without the filesystem being volatile.  That's the only
> reason for the readonly mount: to allow recovery before we enable
> writes.  With ext3, that recovery is done in the kernel, so doing that
> recovery during mount makes perfect sense even if the user is mounting
> root readonly. 


Alternative reasons for readonly mount include "my hard drive is dying and 
I don't want _anything_ to write to it because it'll explode".

You mount it read-only, recover as much as possible from it, and bin it.

You _don't_ want the fs code to ignore your explicit instructions not to
write to the medium, and to destroy whatever data were left.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
