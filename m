Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSDPC5P>; Mon, 15 Apr 2002 22:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313544AbSDPC5P>; Mon, 15 Apr 2002 22:57:15 -0400
Received: from rj.SGI.COM ([204.94.215.100]:38064 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313537AbSDPC5O>;
	Mon, 15 Apr 2002 22:57:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Radez <rob@osinvestor.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [RFC] Making drivers/char/watchdog 
In-Reply-To: Your message of "Mon, 15 Apr 2002 22:32:28 -0400."
             <Pine.LNX.4.33.0204152222100.17511-100000@pita.lan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 12:56:45 +1000
Message-ID: <12454.1018925805@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002 22:32:28 -0400 (EDT), 
Rob Radez <rob@osinvestor.com> wrote:
>This e-mail probably doesn't affect 99% of you out there, but it's coming
>into your inboxes anyways :-).  How would people feel about moving the
>22 watchdog drivers into their own subdirectory off of drivers/char/ in
>both 2.4 and 2.5?  (Well, 2.5 only has 18 at the moment, but I'm planning
>on adding the 4 2.4-only drivers to 2.5 once updating 2.4 is done)
>
>I've received a bunch of inquiries about breaking them into their own
>subdirectory.  At the moment there are 20 watchdog drivers in
>drivers/char/ and 2 in drivers/sbus/char/ in 2.4, and 16 in drivers/char/
>and 2 in drivers/sbus/char/ in 2.5.  I think putting them all into one
>place will make them easier to maintain, more standardized, and less
>buggy.

Moving the watchdogs to their own directory makes sense, but watch out
for config sensitivity.  ATM drivers/sbus is only selected if the arch
is not m68k (anybody know why?) and the whole drivers/sbus/char
directory is conditioned on CONFIG_SBUSCHAR.

