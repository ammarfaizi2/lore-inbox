Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289726AbSAOW4r>; Tue, 15 Jan 2002 17:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289727AbSAOW4d>; Tue, 15 Jan 2002 17:56:33 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:43320 "EHLO
	tsmtp2.mail.isp") by vger.kernel.org with ESMTP id <S289725AbSAOW4L>;
	Tue, 15 Jan 2002 17:56:11 -0500
Date: Wed, 16 Jan 2002 00:00:07 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
CC: james@and.org, esr@thyrsus.com
Subject: Re: Penelope builds a kernel
Reply-To: grundig@teleline.es
In-Reply-To: <nn1ygrw8h1.fsf@code.and.org>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020114173542.C30639@redhat.com> <20020114173854.C23081@thyrsus.com> <20020114180007.D30639@redhat.com> <20020114180522.A24120@thyrsus.com> <20020114183820.G30639@redhat.com> <20020114205307.E24120@thyrsus.com> <nn1ygrw8h1.fsf@code.and.org>
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115225617Z289725-13997+5537@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please leave this discussion about fetchmail out of the list....

On 15 Jan 2002, James Antill wrote:
> "Eric S. Raymond" <esr@thyrsus.com> writes:
> 
> > Benjamin LaHaise <bcrl@redhat.com>:
> > > FYI, it's easy to fix, just use the correct ordering of download,
> transmit, 
> > > delete that sendmail and other MTAs use.
> > 
> > I don't understand what you think you're seeing, but I am sure of
> > this; if I had been enough of a drug-addled lunatic to allow fetchmail
> > to delete mail before getting a positive acknowledge from the
> > downstream MTA, someone in the pool of over two thousand people who
> have sent
> > me bug reports and patches would have called me on it some time in the
> > six years of production use well before *you* entered the picture.
> > 
> > It's likely you're being hosed by an MTA that's sending back bogus 2xx
> > responses.  That's happend before.  Fetchmail can't magically cope
> > with MTAs that tell it lies.
> > 
> > Fetchmail *already works the way you recommend* -- as any idiot can
> > verify by reading the short section of the main driver loop where
> > dispatch and delete takes place.  That's been an invariant of the code
> > since day one, and you thus clearly have no bloody idea what you are
> > flaming about.
> 
>  I'll bite, as I've been forced to use it at times.
> 
> 1. User configures fetchmail to download from imap/pop3 account (with
> the messages kept on the server and just recorded -- Ie. nothing is
> deleted server side).
> 
> 2. User has exim as local transport, and also gets normal SMTP
> traffic.
> 
> 3. User enables sender_verify, sender_verify_hosts_callback and
> sender_verify_callback_domains which catches loads of spam and is
> happy.
> 
>  Then...
> 
> .. User runs fetchmail
> .. fetchmail feeds email to exim
> .. exim does callback verification, and refuses email.
> .. fetchmail pretends it has delivered email, so _even if_ you hack your
>   MTA to say don't verify from localhost lost emails will never be
>   delivered by fetchmail (even though they are still on the server,
>   and fetchmail knew they didn't get sent).
> 
> ....and that assumes that you swallow the argument that you should have
> to reconfigure your MTA to work around fetchmail bugs.
> 
> -- 
> James Antill -- james@and.org
> The Hurd itself is aggressively multi-threaded and all of the locking has
> been done with an eye towards multi-processor systems. That said, we have
> not yet used a microkernel that stably supports multiple cpus.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
