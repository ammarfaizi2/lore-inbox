Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSCOLGg>; Fri, 15 Mar 2002 06:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSCOLDv>; Fri, 15 Mar 2002 06:03:51 -0500
Received: from ns.ithnet.com ([217.64.64.10]:58894 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290767AbSCOLCn>;
	Fri, 15 Mar 2002 06:02:43 -0500
Date: Fri, 15 Mar 2002 12:02:32 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020315120232.6d9b1dd5.skraw@ithnet.com>
In-Reply-To: <20020315133241.A1636@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020315133241.A1636@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 13:32:41 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Mon, Mar 11, 2002 at 04:57:22PM +0100, Stephan von Krawczynski wrote:
> 
> > Conclusion: reiserfs has a problem being nfs-mounted as the only fs to a
> > client. If you add another fs (here ext2) mount, then even reiserfs is happy.
> > The problem is originated at the server side.
> > Any ideas for a fix?
> 
> Ok I tried your scenario of mounting fs1, then mounting fs2, do io on fs2,
> umount fs2 and access fs1 and everything went fine.
> I cannot reproduce this at all. :(

There must be a reason for this. One "non-standard" option in my setup is in /etc/exports:

/p2/backup              192.168.1.1(rw,no_root_squash,no_subtree_check)

Can the "no_subtree_check" be a cause?

What kernels are you using (client,server)?
I am pretty sure we can find the thing, stuff here is pretty straightforward and problem is continously reproducable on several clients.

Regards,
Stephan

