Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVL0FEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVL0FEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVL0FEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:04:54 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:20951 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932227AbVL0FEy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:04:54 -0500
Date: Tue, 27 Dec 2005 03:58:48 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Jules Villard <jvillard@ens-lyon.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051227025848.GA5498@stiffy.osknowledge.org>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261201360.14098@g5.osdl.org> <20051226212339.GA9837@blatterie>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20051226212339.GA9837@blatterie>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc7-marc-g04333393
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jules Villard <jvillard@ens-lyon.fr> [2005-12-26 22:23:39 +0100]:

> Le lun, 26 déc 2005 12:04:54 -0800, Linus Torvalds a écrit :
> > 
> > 
> > On Mon, 26 Dec 2005, Jules Villard wrote:
> > > 
> > > Resuming from a suspend on my ThinkPad T42 is broken in both -rc6 and
> > > -rc7 releases. When X is not launched, everything goes fine, but when
> > > resuming a running X, X looks frozen. I can ssh to my box and the
> > > sysrq keys are still working, but I'm unable to kill the X process.
> > > If I suspend from a vt (but still with a X running), the resume goes
> > > fine until I switch back from the vt to X.
> > 
> > Since you have sysrq working, can you do SysRQ-T and send us the output? 
> > With CONFIG_KALLSYMS (which is on by default unless you do something 
> > really strange).
> > 
> > At least that should tell _where_ X is frozen, assuming it is frozen in 
> > the kernel (which is not necessarily a safe assumption, of course).
> 
> Attached.
> 
> Investigating a bit further, I found out that resume is quite innocent
> about all this: what hangs X is switching from a vt to X. Moreover, When I
> launch X only by typing "X" in a vt, switching back and forth makes
> the box hang hard (ie no sysrq), so I had to do a startx to see a call
> trace with sysrq-t (I know, it may sound like black art).
> 
> Regards,
> 
> Jules

Did you use the nVidia module? Several people reported machine hangs when
doing the vt <-> X switching. This, however, should be fixed with the latest
drivers.

I had the same problem some time ago. Though I knew a have reached a console
where I was logged in the keyboard seems to deny any service when coming from X.
Since i upgraded X to some CVS version and the nVidia driver 8174 (8178 working
as well) anything is OK.

Marc
