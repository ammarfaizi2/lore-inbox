Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUAFUgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 15:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUAFUgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 15:36:45 -0500
Received: from ip-213-226-226-138.ji.cz ([213.226.226.138]:14575 "HELO
	machine.sinus.cz") by vger.kernel.org with SMTP id S265282AbUAFUgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 15:36:41 -0500
Date: Tue, 6 Jan 2004 21:36:35 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Diego Calleja <grundig@teleline.es>, Robert.L.Harris@rdlg.net,
       vherva@niksula.hut.fi, ihaquer@isec.pl, cliph@isec.pl,
       linux-kernel@vger.kernel.org
Subject: mremap() bug indeed not in 2.2 (confirmed)
Message-ID: <20040106203635.GP2093@pasky.ji.cz>
Mail-Followup-To: Diego Calleja <grundig@teleline.es>,
	Robert.L.Harris@rdlg.net, vherva@niksula.hut.fi, ihaquer@isec.pl,
	cliph@isec.pl, linux-kernel@vger.kernel.org
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz> <20040105225508.GM2093@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105225508.GM2093@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Jan 05, 2004 at 11:55:08PM CET, I got a letter,
where Petr Baudis <pasky@ucw.cz> told me, that...
> Dear diary, on Mon, Jan 05, 2004 at 07:26:07PM CET, I got a letter,
> where Petr Baudis <pasky@ucw.cz> told me, that...
> > Dear diary, on Mon, Jan 05, 2004 at 06:10:53PM CET, I got a letter,
> > where Diego Calleja <grundig@teleline.es> told me, that...
> > > It names 2.2 too. Is there a fix for 2.2?
> > 
> > I'm trying to investigate that right now. In 2.2, mremap() doesn't yet
> > take yet the new_addr argument, therefore the "official" 2.4 fix
> > wouldn't apply at all to it. There are four possibilities:
> > 
> > * The isec.pl guys just made a mistake.
..snip..
> Actually, after looking at the code again, I'm now quite convinced 2.2
> has not this particular vulnerability. In order for the exploit to work,
> you'd need mremap() to relocate you.
..snip..
> ihaquer, any comments? Is there something we don't know about? If not,
> please correct your announcement.

It seems to be indeed so. This was just posted to bugtraq & co:

Hi,

our initial posting contains a mistake about the vulnerability of the
2.2 kernel series. Since the 2.2 kernel series doesn't support the
MREMAP_FIXED flag it is NOT vulnerable. The source states "MREMAP_FIXED
option added 5-Dec-1999" but it didn't make into recent 2.2.x. We
apologize for inconvenience.

--
Paul Starzetz
iSEC Security Research
http://isec.pl/

Here you go. And I don't need to worry about my 2.2.25-running pets ;-).

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
The brain is a wonderful organ; it starts working the moment you get up
in the morning, and does not stop until you get to work.
.
Stuff: http://pasky.or.cz/
