Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269249AbRGaLAJ>; Tue, 31 Jul 2001 07:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269250AbRGaK77>; Tue, 31 Jul 2001 06:59:59 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:1028 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269249AbRGaK7m>; Tue, 31 Jul 2001 06:59:42 -0400
Message-ID: <3B668FA2.5E76BE1E@namesys.com>
Date: Tue, 31 Jul 2001 14:59:46 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33L.0107301904060.5582-100000@duckman.distro.conectiva> <3B65E177.D77ACA45@namesys.com> <20010731223203.B7257@weta.f00f.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Wedgwood wrote:
> 
> On Tue, Jul 31, 2001 at 02:36:39AM +0400, Hans Reiser wrote:
> 
>     If you could halve linux memory manager performance and check as
>     many things as reiserfs checks, would you do it.  I think not, or
>     else you would have.  You made the right choice.  Now, if you add
>     a #define, you can check as many things as ReiserFS checks, and
>     still go just as fast....
> 
> The memory manager is stress much more often that reiserfs, EVERYBODY
> has it.
> 
> The MM system does have various sanity checks, things might be
> slightly faster without them, but having the sanity checks is still
> very important.
> 
> If the memory manager does something bad, chances are your system will
> go boom --- upon reboot all is happy.  If as fs goes bad, that
> corruption might still be there when you reboot, even if to another
> kernel!  This is a major difference.
> 
> Anyhow, I use resierfs with debugging/checking on in lots of places.
> The speed difference is negligible, so I think this whole thread is
> pointless.
> 
> FWIW, if the mainline kernels remove the debugging option, I will hack
> it back in --- I for one am happy with the performance and am pleased
> there is additional sanity checking.
> 
>   --cw
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Last I ran benchmarks the performance cost was 30-40%, but this was some time
ago.  I think that the coders have been quietly culling some checks out of the
FS, and so it does not cost as much anymore.  I would prefer that the "excesive"
checks had stayed in.

Sigh, I see I cannot persuade in this argument.  It seems Linus is right, and
debugging checks don't belong in debugged code even if they would make it easier
for persons hacking on the code to debug their latest hacks.

Hans
