Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266644AbSKGWtr>; Thu, 7 Nov 2002 17:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbSKGWtq>; Thu, 7 Nov 2002 17:49:46 -0500
Received: from almesberger.net ([63.105.73.239]:36874 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266644AbSKGWtk>; Thu, 7 Nov 2002 17:49:40 -0500
Date: Thu, 7 Nov 2002 19:56:01 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: kexec (was: [lkcd-devel] Re: What's left over.)
Message-ID: <20021107195601.J10679@almesberger.net>
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com> <m14ratepbf.fsf@frodo.biederman.org> <1036697556.10457.254.camel@andyp> <1036707232.10457.275.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036707232.10457.275.camel@andyp>; from andyp@osdl.org on Thu, Nov 07, 2002 at 02:13:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer wrote:
> I'm still pondering the kexec-ish reboot after panic() with this kind of
> mechanism.  Ah well, it's just an idea.

Yes, that's where the problems get really nasty. Also, for such
cases, you want the pages to be mlock'ed. Furthermore, you'd
have to tell init about this magic process. (Which would be
tricky, because e.g. sysvinit simply uses kill(-1,...).)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
