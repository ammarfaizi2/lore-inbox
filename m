Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265363AbRF0Skf>; Wed, 27 Jun 2001 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265366AbRF0SkQ>; Wed, 27 Jun 2001 14:40:16 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:4878 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S265363AbRF0Sjy>; Wed, 27 Jun 2001 14:39:54 -0400
Date: Wed, 27 Jun 2001 14:38:46 -0400
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
Message-ID: <898940000.993667126@tiny>
In-Reply-To: <Pine.LNX.4.33L.0106271515260.23373-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, June 27, 2001 03:16:09 PM -0300 Rik van Riel <riel@conectiva.com.br> wrote:

> On Wed, 27 Jun 2001, Chris Mason wrote:
>> On Wednesday, June 27, 2001 04:27:45 PM +0200 Xuan Baldauf <xuan--lkml@baldauf.org> wrote:
>> 
>> > My linux box suddenly was not availbale using ssh|telnet,
>> > but it responded to pings. On console login, I could type
>> > "root", but after pressing "return", there was no reaction,
>> 
>> Sounds like a deadlock andrea recently found.
> 
> It would be nice if Andrea would TELL US every
> once in a while what he found ;)

Well, I got an auto-reply from andrea saying he wasn't reading email until
July 5th (yeah, I've gotten other mails since then, we all know how
that goes ;-) 

The orig email I had regarding the patch was he thought some 
of the page lists were getting corrupted, leading to someone trying to free
a page that didn't exist anymore.  This was a recent discovery, I don't
think the patch is even in an aa kernel yet ;-)

Since Xuan's stack trace had things waiting in deactivate page, it sounded
similar to the problem andrea described.  We had a few test boxes
hanging under load, they are testing the patch now, plus Xuan, plus
one other l-k user.  If their problems go away, we'll have to dig to
find the exact corruption.

-chris

