Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271289AbTHMAwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271302AbTHMAwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:52:09 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:64998
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S271289AbTHMAwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:52:02 -0400
Date: Wed, 13 Aug 2003 02:54:28 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@kolivas.org
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Message-Id: <20030813025428.3569ffbc.lista1@telia.com>
In-Reply-To: <200308130715.23046.kernel@kolivas.org>
References: <20030812172358.5afe0cc1.lista1@telia.com>
	<200308130715.23046.kernel@kolivas.org>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 07:15:22 +1000
Con Kolivas wrote:

> On Wed, 13 Aug 2003 01:23, Voluspa wrote:
> > On 2003-08-12 14:42:02 gaxt wrote:
> > Similar experience here running the game-test (xfree86 4.3.99.10,
> > winex 3.1 and "Baldurs Gate I") on a PII 400 with 128 meg ram. Using
> > 2.6.0-test3-O14.1int + O14.1-O15int.
> 
> Yes known issue for reason I mentioned. Currently investigating.

Yupp, you posted while I was writing.

> > I would say this is the best _and_ worst scheduler I've tried since
> > Con
> 
> Can you give us some idea what your machine is like when it's not
> running a cpu hog win32 game in wine? Also can you try running your
> game nice +1

As I've said, it is extremely hard for me to notice the scheduler unless
I run something graphic intensive, but my comments are of course not
solely based on that game-test. A general feel of smoothness can always
be attributed to the placebo effect, though I challenge anyone to
dispute the following experience.

Fourteen days ago I took home a precompiled Blender 2.28 - previous
copy of this 3D render program to reside here was 2.23. Grabbing the
grid which constitutes the world plane (hold third mouse button, drag)
and rotating it around the axes, I noticed something not present in the
old version. Jerks...

In kernel time this is 2.6.0-test1/2 and Cons O11int. Since then I've
done the "world rotate" on plain kernels and all O-patches without
noticing any improvement. Either mouse pointer or grid gets stuck for
about 1/2 to 2 seconds, making the movement unsynchronized. Can happen
while moving slowly, or spinning like crazy.

I don't have DRI with my mach64 (8 meg) because of choice, use Xv
instead, so I had made up my mind about the blame. Sloppy programming
and weak CPU.

Until O15int enters the mix. Perfect sync all the time, no matter how
slow, fast or long I rotate the world plane. That is why I call this
scheduler the "best". The "worst" part comes from the "known issue" but
also because I happened to run xmms on a directory of mp3s while
rotating. I got severe blackouts in the music, ca 10 - 15 seconds long.
When the blackout starts I no longer have to move the mouse, it is
enough to hold down the button. The second I release it, the music
returns.

Xmms has not been involved in the rotating before, so can't tell if the
blackouts have occurred. Could be due to the "known issue", but I'll
retest with older kernels when time permits.

Running the game-test with nice +1... Well, I tried that first on
wineserver, then wine, then X, after which I put -1 on them
consecutively. No real pattern emerged. Badness all around. And now I'm
falling asleep. Bye.

Mvh
Mats Johannesson
