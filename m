Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSHHWhM>; Thu, 8 Aug 2002 18:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318066AbSHHWhM>; Thu, 8 Aug 2002 18:37:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17292 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318065AbSHHWhK>; Thu, 8 Aug 2002 18:37:10 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Aug 2002 17:34:02 -0500
Message-Id: <1028846042.19434.342.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 17:02, Linus Torvalds wrote:
> 
> On Thu, 8 Aug 2002, Hubertus Franke wrote:
> > 
> > That is true. All was done under the 16-bit assumption
> > My hunch is that the current algorithm might actually work quite well
> > for a sparsely populated pid-space (32-bits).
> 
> I agree.
The original issue that I had with all of this is the fact that if the
current algorithm can't find an available pid, it just sits there
churning forever and hangs the machine.  My original patch was really
just a very basic fix for that (see the 2.4 tree).  This makes it far
more unlikely for us to max out, but if we do aren't we just going to
have the same trouble all over?

Thanks,
Paul Larson

