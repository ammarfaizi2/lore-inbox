Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130312AbRARSZR>; Thu, 18 Jan 2001 13:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRARSZH>; Thu, 18 Jan 2001 13:25:07 -0500
Received: from palrel1.hp.com ([156.153.255.242]:34316 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S130312AbRARSYz>;
	Thu, 18 Jan 2001 13:24:55 -0500
Message-ID: <3A6734F0.E436B1A3@cup.hp.com>
Date: Thu, 18 Jan 2001 10:24:48 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181358010.823-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Wed, 17 Jan 2001, Rick Jones wrote:
> 
> > i'd heard interesting generalities but no specifics. for instance,
> > when the send is small, does TCP wait exclusively for the app to
> > flush, or is there an "if all else fails" sort of timer running?
> 
> yes there is a per-socket timer for this. According to RFC 1122 a TCP
> stack 'MUST NOT' buffer app-sent TCP data indefinitely if the PSH bit
> cannot be explicitly set by a SEND operation. Was this a trick question?
> :-)

Nope, not a trick question. The nagle heuristic means that small sends
will not wait indefinitely since sending the first small bit of data
starts the retransmission timer as a course of normal processing. So, I
am not in the habit of thinking about a "clear the buffer" timer being
set when a small send takes place but no transmit happens.

rick jones

btw, as I'm currently on linux-kernel, no need to cc me :)
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
