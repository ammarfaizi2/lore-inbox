Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136700AbREATat>; Tue, 1 May 2001 15:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136701AbREATaj>; Tue, 1 May 2001 15:30:39 -0400
Received: from fjetret.sletner.com ([195.159.2.90]:14600 "HELO
	mail.sletner.com") by vger.kernel.org with SMTP id <S136700AbREATaf>;
	Tue, 1 May 2001 15:30:35 -0400
Date: Tue, 1 May 2001 21:29:55 +0200
From: Stian Sletner <stian@sletner.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Dead keys
Message-ID: <20010501212955.B17376@sletner.com>
In-Reply-To: <UTC200105011920.VAA57933.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <UTC200105011920.VAA57933.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, May 01, 2001 at 09:20:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* At 2001-05-01T21:20+0200, Andries.Brouwer@cwi.nl wrote:
: 
| I think the main reason why it shouldn't be applied is that it changes
| something. This keyboard stuff is unbelievably complicated. Many people
| and distributions have wrestled with it and have got it working for them.
| When you change stuff, you force people to start worrying about this again.
| 
| [In other words, a global rewrite may be allowed, but non-compatible changes
| in a few details only is really a bad idea.]

Won't comment on this argument, it might outweigh my point (but that's
not for me to say).

| But there are other reasons why your patch is a bad idea. Everybody has
| a double quote in his keymap, so using that to create umlauts is easy.
| Only few people have a diaeresis in their keymap, so requiring a diaeresis
| makes life more difficult for most people.

It doesn't require anyone to use the ISO characters.  The defkeymap.map
still contains compose rules for the ASCII sequences.

| (In other words, composing ASCII to make ISO 8859-1 is better than composing
| ISO 8859-1 to make ISO 8859-1.)

This is just a matter of adding compose rules.  The issue here is that
the dead keys themselves are producing the wrong characters.

| Finally, you have loadkeys. If you change your private keymap
| you achieve what you desire for yourself without disturbing others.

No, this doesn't seem to be the case, unless I've missed something
important.  Because the dead_* are wrong, and I can't change them with a
keymap, afaik?  If I'm wrong, shoot me, then the patch is pointless.

-- 
Stian Sletner
