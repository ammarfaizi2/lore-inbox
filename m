Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTBQNyP>; Mon, 17 Feb 2003 08:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbTBQNyP>; Mon, 17 Feb 2003 08:54:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8840
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267123AbTBQNyM>; Mon, 17 Feb 2003 08:54:12 -0500
Subject: Re: [PATCH] Prevent setting 32 uids/gids in the error range
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, tridge@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cyeoh@samba.org, sfr@canb.auug.org.au
In-Reply-To: <1045493720.19397.4.camel@irongate.swansea.linux.org.uk>
References: <20030217074920.E76822C003@lists.samba.org>
	 <1045493720.19397.4.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045494316.19397.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 17 Feb 2003 15:05:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 14:55, Alan Cox wrote:
> On Mon, 2003-02-17 at 07:41, Rusty Russell wrote:
> > Tridge noticed that getegid() was returning EPERM.
> > 
> > I used -1000 since that's what PTR_ERR uses, but i386 _syscall macros
> > use -125: I don't suppose it really matters.
> 
> Thats a bug in the interface. getegid/getgid/setegid/setuid() is not permitted to fail.

I meant geteuid/getuid not set* - set* can fail.

