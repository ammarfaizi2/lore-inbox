Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278698AbRJ1WGU>; Sun, 28 Oct 2001 17:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278699AbRJ1WF7>; Sun, 28 Oct 2001 17:05:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278698AbRJ1WF4>; Sun, 28 Oct 2001 17:05:56 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Date: Sun, 28 Oct 2001 22:04:16 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rhvd0$7ec$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110281014300.7438-100000@penguin.transmeta.com> <E15xvcd-0000FM-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1004306766 7756 127.0.0.1 (28 Oct 2001 22:06:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 28 Oct 2001 22:06:06 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15xvcd-0000FM-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> Yes. My question is more: does the dpt366 thing limit the queueing some
>> way?
>
>Nope. The HPT366 is a bog standard DMA IDE controller. At least unless Andre
>can point out something I've forgotten any behaviour seen on it should be
>the same as seen on any other IDE controller with DMA support.
>
>In practical terms that should mean you can obsere the same HPT366 problem
>he does on whatever random IDE controller is on your desktop box

Well, the thing is, I obviously _don't_ observe that problem. Neither
does anybody else I have heard about. I get a nice 20MB/s on my IDE
disks both at home and at work, whether reading or writing. 

Which was why I was suspecting the hpt366 code. But considering that
others report good performance with the same controller, it might be
something even more localized, either in just Zlatko's setup (ie disk or
controller breakage), or some subtle timing issue that is general but
you have to have just the right timing to hit it.

		Linus
