Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUAES2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUAES2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:28:36 -0500
Received: from ip-213-226-226-138.ji.cz ([213.226.226.138]:56046 "HELO
	machine.sinus.cz") by vger.kernel.org with SMTP id S265246AbUAES0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:26:10 -0500
Date: Mon, 5 Jan 2004 19:26:07 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Diego Calleja <grundig@teleline.es>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Robert.L.Harris@rdlg.net,
       linux-kernel@vger.kernel.org
Subject: mremap() bug and 2.2?
Message-ID: <20040105182607.GB2093@pasky.ji.cz>
Mail-Followup-To: Diego Calleja <grundig@teleline.es>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Robert.L.Harris@rdlg.net, linux-kernel@vger.kernel.org
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040105181053.6560e1e3.grundig@teleline.es>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Jan 05, 2004 at 06:10:53PM CET, I got a letter,
where Diego Calleja <grundig@teleline.es> told me, that...
> El Mon, 5 Jan 2004 13:26:23 -0200 (BRST) Marcelo Tosatti <marcelo.tosatti@cyclades.com> escribió:
> 
> > On Mon, 5 Jan 2004, Robert L. Harris wrote:
> > > Just read this on full disclosure:
> > >
> > > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> [...]
> > It is possible that the problem is exploitable. There is no known public
> > exploit yet, however.
> > 
> > 2.4.24 includes a fix for this (mm/mremap.c diff)
> 
> It names 2.2 too. Is there a fix for 2.2?

I'm trying to investigate that right now. In 2.2, mremap() doesn't yet
take yet the new_addr argument, therefore the "official" 2.4 fix
wouldn't apply at all to it. There are four possibilities:

* The isec.pl guys just made a mistake.

* 2.2's get_unmapped_area() can return dangerous pages for len == 0,
whilst the 2.4's get_unmapped_area() cannot. (I'm not sure, looking into
that code right now.)

* 2.4's fix is incorrect.

* I'm missing something obvious.

Anyone has an idea?

-- 
 
				Petr "Pasky" Baudis
.
The brain is a wonderful organ; it starts working the moment you get up
in the morning, and does not stop until you get to work.
.
Stuff: http://pasky.or.cz/
