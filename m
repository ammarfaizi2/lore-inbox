Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285288AbRLXUJp>; Mon, 24 Dec 2001 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285291AbRLXUJ0>; Mon, 24 Dec 2001 15:09:26 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:44439 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S285288AbRLXUJX> convert rfc822-to-8bit; Mon, 24 Dec 2001 15:09:23 -0500
Date: Mon, 24 Dec 2001 15:09:07 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
In-Reply-To: <20011224203828.G2461@lug-owl.de>
Message-ID: <Pine.LNX.4.43.0112241507550.31883-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Jan ,  Is this possibly related to a ECN enabled host &
	somewhere in between a Non-ECN enabled (or a cisco router) ?
		Just a thought ,  JimL

On Mon, 24 Dec 2001, Jan-Benedict Glaw wrote:

> On Mon, 2001-12-24 19:10:32 +0100, José Luis Domingo López <jdomingo@internautas.org>
> wrote in message <20011224181031.GA7934@localhost>:
> > On Monday, 24 December 2001, at 18:01:42 +0100,
> > Jan-Benedict Glaw wrote:
> > > I've got some problem with a freshly installed Debian sid system.
> > > It's running with 2.4.16, 2.4.17-rc2 and 2.4.17 (the problem
> > > appears on all these kernels) and something seems to break ssh.
> >
> > My own experience with Debian's ssh is that, sooner or later,
> > X-forwarding fails, with Send-Q (or Recv-Q) in the server side
> > completely full. The server side was Debian Sid, and client side was
> > Debian Woody, and it happened with both a simple xclock and gkrellm (ssh
> > remoteserver xclock, ssh remoteserver gkrellm).
>
> Seems to bo a more general problem. I just installed ftpd and telnetd.
> *Both* of them show exactly the same behaviour: 'ls -l' via  telnet
> blocks also. I could get a 635 byte file via ftp, but fetching a
> 69294 bytes long file stalled. (This time, strace shows that ftpd is
> sitting in write(5, ...data..., 56262), and there are
> 13032 bytes in Send-Q for ftpd...)
>
> So what is this? Seems that there's a general TCP I/O problem with
> the software current software versions in Debian unstable. libc
> problem? Could a lousy network card cause this? Are there any
> debugging hints for me?
>
> MfG, JBG
>
> --
> Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
> 	 -- New APT-Proxy written in shell script --
> 	   http://lug-owl.de/~jbglaw/software/ap2/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

