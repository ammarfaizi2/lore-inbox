Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132455AbRAERwk>; Fri, 5 Jan 2001 12:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131389AbRAERwa>; Fri, 5 Jan 2001 12:52:30 -0500
Received: from hermes.mixx.net ([212.84.196.2]:30736 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129859AbRAERwN>;
	Fri, 5 Jan 2001 12:52:13 -0500
Message-ID: <3A56091B.1126A290@innominate.de>
Date: Fri, 05 Jan 2001 18:49:15 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <662960000.978710044@tiny> <Pine.LNX.4.21.0101051318190.2745-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Fri, 5 Jan 2001, Chris Mason wrote:
> 
> >
> > Here's the latest version of the patch, against 2.4.0.  The
> > biggest open issues are what to do with bdflush, since
> > page_launder could do everything bdflush does.
> 
> I think we want to remove flush_dirty_buffers() from bdflush.
> 
> While we are trying to be smart and do write clustering at the ->writepage
> operation, flush_dirty_buffers() is "dumb" and will interfere with the
> write clustering.

Actually, I found it doesn't interfere that much.  Remember, there's
still an elevator in there.  Even if bdflush and clustered page flushing
are running at the same time the elevator makes the final decision what
gets written when.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
