Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbRLQMf1>; Mon, 17 Dec 2001 07:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285113AbRLQMfR>; Mon, 17 Dec 2001 07:35:17 -0500
Received: from [195.157.147.30] ([195.157.147.30]:60937 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S285099AbRLQMfI>; Mon, 17 Dec 2001 07:35:08 -0500
Date: Mon, 17 Dec 2001 12:30:45 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, Chris Wright <chris@wirex.com>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Message-ID: <20011217123045.D14112@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Matthew Kirkwood <matthew@hairy.beasts.org>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	Chris Wright <chris@wirex.com>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011217115344.C14112@dev.sportingbet.com> <Pine.LNX.4.33.0112171205590.10824-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112171205590.10824-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Mon, Dec 17, 2001 at 12:06:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Doh!</slaps head>

Sean


On Mon, Dec 17, 2001 at 12:06:30PM +0000, Matthew Kirkwood wrote:
> On Mon, 17 Dec 2001, Sean Hunter wrote:
> 
> > > Hmm. Looking at killall5 source I see
> > >
> > > kill(-1, STOP);
> > > for(each proc with p.sid!=my_sid) kill(proc, sig);
> > > kill(-1, CONT);
> > >
> > > I guess STOP will stop killall5 too? Not good indeed.
> 
> > Couldn't it just do:
> [..]
> > ... in other words, block signals, do the killing, then unblock?
> 
> SIGSTOP and SIGKILL can't be blocked.
> 
> Matthew.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
