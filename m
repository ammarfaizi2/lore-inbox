Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280827AbRKONdT>; Thu, 15 Nov 2001 08:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKONdJ>; Thu, 15 Nov 2001 08:33:09 -0500
Received: from ns0.ipal.net ([206.97.148.120]:62149 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280827AbRKONdC>;
	Thu, 15 Nov 2001 08:33:02 -0500
Date: Thu, 15 Nov 2001 07:32:57 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: kees <kees@schoen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: straced processes don't go away
Message-ID: <20011115073257.A16769@vega.ipal.net>
In-Reply-To: <Pine.LNX.4.33.0111150836290.20276-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111150836290.20276-100000@schoen3.schoen.nl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 08:39:30AM +0100, kees wrote:

| In my attempts to find the problem with the tun device I did
| a couple of strace sessions.
| 
| My processlist now shows a couple of unkillable (kill -KILL )
| processes:
| 
| 444     0 24239     1   9   0     0    0 do_exi RW   ?          0:00
| [vtund]
| 444     0 24305     1   8   0     0    0 do_exi RW   ?          0:00
| [vtund]
| 444     0 24880     1   9   0     0    0 do_exi RW   ?          0:00
| [vtund]
| 
| kernel 2.4.14 with 2.4.15-pre3 applied

I've been debugging some timer bugs in a daemon library I'm developing
and have been stracing it.  Among many things done are a variety of
kills, including -KILL, -INT, -TERM and -HUP, while being straced.
When I do the kill, I see strace output showing the events correctly
and in the case of -KILL the process definitely goes away.

This is with kernel 2.4.13.  So this is not a broad problem and may be
specific to states vtund is in, or changes since 2.4.13, or both.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
