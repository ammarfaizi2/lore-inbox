Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTCTRwF>; Thu, 20 Mar 2003 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbTCTRwF>; Thu, 20 Mar 2003 12:52:05 -0500
Received: from a052082.dsl.fsr.net ([12.32.52.82]:12977 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id <S261352AbTCTRwD>;
	Thu, 20 Mar 2003 12:52:03 -0500
Message-ID: <47137.134.121.46.137.1048185088.squirrel@mail.sandall.us>
Date: Thu, 20 Mar 2003 10:31:28 -0800 (PST)
Subject: Re: Deprecating .gz format on kernel.org
From: "Eric Sandall" <eric@sandall.us>
To: <jamie@shareable.org>
In-Reply-To: <20030320173920.GA2362@mail.jlokier.co.uk>
References: <3E78D0DE.307@zytor.com>
        <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
        <20030320002127.GB7887@mail.jlokier.co.uk>
        <43255.134.121.46.137.1048182821.squirrel@mail.sandall.us>
        <20030320173920.GA2362@mail.jlokier.co.uk>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier said:
> Eric Sandall wrote:
>> Jamie Lokier said:
>> <snip>
>> > Which is ok of course, but then the signatures don't match any more.
>> <snip>
>> > -- Jamie
>>
>> Why not get the signature from the .tar file, that way the compression
>> method doesn't matter?  This is how Source Mage does it's checking, we
>> create and md5sum (and soon GPG) signature based on the uncompressed
>> .tar file.  This way, you can use any compression you want, even
>> changing around the compression to your favourite one, and the
>> signatures will always match.  :)
>
> (a) I use .gz for the patches not the tar files.  But your point still
> applies.
>
> (b) On something as large as a .tar, decompressing a bz2 file to check
>     the signature is really quite slow, compared with checking the
> signature of the compressed file.
>
> -- Jamie

True...for large files it'd be nice to know if you have the correct
tarball _before_ spending all that CPU time decompressing it.  It's a
trade off, mostly, CPU time for more generic useage.  I know this isn't
the Right Way(TM), but since fast computers are becoming fairly cheap, I
say the signature on the .tar file is a good way to go.  However, Linux
also runs sufficiently well on slow machines, and this would just make
them slower.  Shall we just follow the path of least resistence and keep
it as is?

-Sandalle

-- 
PGP Key 0x5C8D199A5A317214
http://search.keyserver.net:11371/pks/lookup?op=get&search=0x5A317214

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/


