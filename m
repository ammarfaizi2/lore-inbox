Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRASOjt>; Fri, 19 Jan 2001 09:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132206AbRASOjj>; Fri, 19 Jan 2001 09:39:39 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:10259 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S132147AbRASOjZ>;
	Fri, 19 Jan 2001 09:39:25 -0500
Message-ID: <3A685190.A8CB3D1F@holly-springs.nc.us>
Date: Fri, 19 Jan 2001 09:39:12 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mo McKinlay <mmckinlay@gnu.org>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101191417510.663-100000@nvws005.nv.london>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:
> 
>   > Unfortunately, unix allows everything but "/" in filenames. This was
>   > probably a mistake, as it makes it nearly impossible to augment the
>   > namespace, but it is the reality.
> 
>   > Did you read the "new namespace" section of the paper?
> 
> I've not, so pardon me if I make a bad assumption (and slap me for it,
> too), but doesn't introducing a new namespace segregate the streams from
> the files/directories, thus introducing an artifical separation which
> isn't really there? (Pretty much why I'm more in favour of a specific API
> for reading streams, extended attributes and whatnot, over any of the
> other solutions thus suggested).

Well, EAs are accessed via a special API. The paper also covers that.
Streams, however, are by nature accessed as files; this is what makes
them not EAs. EAs are set and retrieved atomically. Streams can be used
with open(), seek(), read(), write(), etc. This is actually more "unixy"
than EAs, as the usual set of Unix functions and tools can work with
streams unmodified; i.e., without knowledge of a special API. Of course,
cp() is the exception. It would have to be able to enumerate and copy
all the streams.

If you have time, please read over the paper so we don't get into the
same rut we got into last time. :)

http://www.flyingbuttmonkeys.com/streams-on-posix.txt
http://www.flyingbuttmonkeys.com/streams-on-posix.pdf

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
