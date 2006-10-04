Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWJDE0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWJDE0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWJDE0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:26:14 -0400
Received: from relay01.pair.com ([209.68.5.15]:38929 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932374AbWJDE0N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:26:13 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: "Julio Auto" <mindvortex@gmail.com>
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
Date: Tue, 3 Oct 2006 23:25:47 -0500
User-Agent: KMail/1.9.4
Cc: goodfellas@shellcode.com.ar, "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, endrazine <endrazine@gmail.com>,
       "Stephen Hemminger" <shemminger@osdl.org>, Valdis.Kletnieks@vt.edu,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
References: <18d709710610032108w52d69b17mfa585e40ad2ae72c@mail.gmail.com>
In-Reply-To: <18d709710610032108w52d69b17mfa585e40ad2ae72c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610032326.10710.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 23:08, Julio Auto wrote:
> I sincerely think you're all missing the point here.
>
> The observation is in fact something that can be used by rootkit
> writers or developers of other forms of malware. Meaning that this is
> always something else that people who work to make Linux a safer
> environment will have to watch and look for (think of rootkit
> detectors, for an example). I'm glad they've reported it, as someone
> might be using it already for God knows how long. All very stealthy.
> All I can think is that this is a very good opportunity for us to
> rethink some designs and see if a little bit of effort wouldn't be
> worth the advantages a patch might bring.
>
> Don't get me wrong. I truly appreciate the freedom that Linux
> provides, but this "well, root should be able to do anything, anyway"
> mentality won't get this OS anywhere security-wise. If everyone
> thought like that, then I'd guess that sys_call_table would be an
> exported symbol until now, linux-gate wouldn't be randomized, and so
> on.

Julio,
	No one is trying to paper over any real problem here. This attack relies on 
being able to insert an arbitrary kernel module into the running kernel. If 
you can do that, you can literally load _any_ code you want. Attaching to the 
binfmt callback list is one of about a billion things you could do.
	If you're worried about this kind of attack, the only way to be safe is to 
turn off kernel module support or use another mechanism to restrict who can 
load them.
	I think it's a little bit silly for a "security researcher" to simultaneously 
publish stuff in the news and in a developer community, especially if the 
threat is totally phony to begin with.

> Just a thought.
>
> Cheers,
>
>     Julio Auto

Thanks,
Chase

> On 10/4/06, Chase Venters <chase.venters@clientec.com> wrote:
> > On Tuesday 03 October 2006 14:12, SHELLCODE Security Research wrote:
> > > Hello,
> > > The present document aims to demonstrate a design weakness found in the
> > > handling of simply
> > > linked   lists   used   to   register   binary   formats   handled   by
> > > Linux   kernel,   and   affects   all   the   kernel families
> > > (2.0/2.2/2.4/2.6), allowing the insertion of infection modules in
> > > kernel­ space that can be used by malicious users to create infection
> > > tools, for example rootkits.
> >
> > Yay, you've been Slashdotted!
> >
> > Question: Why did you personally submit this to Slashdot when it is
> > absolutely clear that the observation is akin to figuring out a process
> > can call fork() and exec() and become "/bin/rm" with an argv of
> > "/bin/rm", "-rf", and "*"?
> >
> > Is this what you call good marketing?
> >
> > > POC, details and proposed solution at:
> > > English version: http://www.shellcode.com.ar/docz/binfmt-en.pdf
> > > Spanish version: http://www.shellcode.com.ar/docz/binfmt-es.pdf
> >
> > Thanks,
> > Chase
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
