Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSCTWnp>; Wed, 20 Mar 2002 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312260AbSCTWnf>; Wed, 20 Mar 2002 17:43:35 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4364 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312253AbSCTWnV>; Wed, 20 Mar 2002 17:43:21 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: Bitkeeper licence issues
Date: Wed, 20 Mar 2002 22:42:20 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <20020318212617.GA498@elf.ucw.cz>
    <20020318144255.Y10086@work.bitmover.com>
    <20020318231427.GF1740@atrey.karlin.mff.cuni.cz>
    <20020319002241.K17410@suse.de> <20020318180233.D10086@work.bitmover.com>
    <20020319215800.GN12260@atrey.karlin.m__.cuni.cz>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1016664140 27399 10.253.0.3 (20 Mar 2002
    22:42:20 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Wed, 20 Mar 2002 22:42:20 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:143157
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <a7b38c$qo7$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020319215800.GN12260@atrey.karlin.m__.cuni.cz>,
	Pavel Machek <pavel@suse.cz> writes:
> If nasty user on same system creates symlink (ln -s /etc/passwd
> /tmp/installer123), he may overwrite any file on the system. You probably want
> 
> fd = open(installer_name, O_WRONLY | O_TRUNC | O_CREAT | O_EXCL, 0755);
> 
> Same goes for data.
> 								Pavel
fd = open(installer_name, O_WRONLY | O_TRUNC | O_CREAT | O_EXCL, 0777);

the 0777 will still be modified by the umask. If people want e.g.
writability for group for some reason, let them.
