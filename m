Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSHHWkr>; Thu, 8 Aug 2002 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318100AbSHHWkr>; Thu, 8 Aug 2002 18:40:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45328 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318097AbSHHWkq>; Thu, 8 Aug 2002 18:40:46 -0400
Date: Thu, 8 Aug 2002 19:44:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Paul Larson <plars@austin.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, <andrea@suse.de>,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <1028846042.19434.342.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.44L.0208081941420.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Aug 2002, Paul Larson wrote:

> The original issue that I had with all of this is the fact that if the
> current algorithm can't find an available pid, it just sits there
> churning forever and hangs the machine.  My original patch was really
> just a very basic fix for that (see the 2.4 tree).  This makes it far
> more unlikely for us to max out, but if we do aren't we just going to
> have the same trouble all over?

You'll need at least 330 million tasks to run out.

At a minimum kernel memory allocation of about 8 kB per
task, that's about 2600 GB of kernel data structures.

I'm not sure we'll hit that limit, ever. Not because
we won't have a TB of kernel data space at some point
in the future, but because 330 million tasks is a lot
more than we'd want to manage with just a few CPUs ;)

kind regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

