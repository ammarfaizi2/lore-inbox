Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287572AbSAHCZR>; Mon, 7 Jan 2002 21:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287577AbSAHCZI>; Mon, 7 Jan 2002 21:25:08 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:62815 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287572AbSAHCYz>; Mon, 7 Jan 2002 21:24:55 -0500
Date: Mon, 7 Jan 2002 21:24:45 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] in 2.4.17 after 10 days uptime
Message-ID: <20020107212445.A7376@redhat.com>
In-Reply-To: <20020101145605.B3283@redhat.com> <Pine.LNX.4.21.0201071623380.18722-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201071623380.18722-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Jan 07, 2002 at 04:28:12PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 04:28:12PM -0200, Marcelo Tosatti wrote:
> Is my thinking correct ?

Yes, that's the case I was thinking of.  sendfile() and tux are potential 
triggers of this.

> If so, I don't see why Ed's trace BUGs at rmqueue first: It should bug at
> __free_pages_ok() PageLRU check.

Hmm, as we've discussed on irc, there are some other nasty implications of 
the __free_pages code interacting with shrink_cache without this patch.  I'm 
not certain that explains it, but it could.  Ed, have you seen this oops 
again?  What kind of load is the machine under?

		-ben
-- 
Fish.
