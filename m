Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132225AbRAFUfp>; Sat, 6 Jan 2001 15:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132900AbRAFUff>; Sat, 6 Jan 2001 15:35:35 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:11785 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132225AbRAFUf2>; Sat, 6 Jan 2001 15:35:28 -0500
Date: Sat, 06 Jan 2001 15:35:02 -0500
From: Chris Mason <mason@suse.com>
To: Stefan Traby <stefan@hello-penguin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <69400000.978813302@tiny>
In-Reply-To: <20010106210951.A3143@stefan.sime.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, January 06, 2001 09:09:51 PM +0100 Stefan Traby
<stefan@hello-penguin.com> wrote:

> On Sat, Jan 06, 2001 at 08:57:26PM +0100, Marc Lehmann wrote:
> 
>> reply. Sure, you can do virtual log replays, but for example the reiserfs
>> log is currently 32mb. Pinning down that much memory for a virtual log
>> reply is not possible on low-memory machines.
> 
> Nobody with working brain would read it completely into memory.
> One just put the block-# that are in the journal into a hash-table
> and read the block out of the journal when it's requested.
> Because there may be multiple copies of the same block in the
> journal, one should take the newest one that can be found in
> the last commited transaction.
> 
> IMHO Chris Mason already wrote such code, at least he talked about
> it...
> 
Talked about it, but never wrote it.  However,  I know there was code to do
this for grub, I'm not sure if it ever made it into their releases.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
