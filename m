Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285266AbRLXTiv>; Mon, 24 Dec 2001 14:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285269AbRLXTik>; Mon, 24 Dec 2001 14:38:40 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:51468 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285266AbRLXTia> convert rfc822-to-8bit;
	Mon, 24 Dec 2001 14:38:30 -0500
Date: Mon, 24 Dec 2001 20:38:29 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224203828.G2461@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011224180142.E2461@lug-owl.de> <20011224181031.GA7934@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20011224181031.GA7934@localhost>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-24 19:10:32 +0100, José Luis Domingo López <jdomingo@internautas.org>
wrote in message <20011224181031.GA7934@localhost>:
> On Monday, 24 December 2001, at 18:01:42 +0100,
> Jan-Benedict Glaw wrote:
> > I've got some problem with a freshly installed Debian sid system.
> > It's running with 2.4.16, 2.4.17-rc2 and 2.4.17 (the problem
> > appears on all these kernels) and something seems to break ssh.
> 
> My own experience with Debian's ssh is that, sooner or later,
> X-forwarding fails, with Send-Q (or Recv-Q) in the server side
> completely full. The server side was Debian Sid, and client side was
> Debian Woody, and it happened with both a simple xclock and gkrellm (ssh
> remoteserver xclock, ssh remoteserver gkrellm).

Seems to bo a more general problem. I just installed ftpd and telnetd.
*Both* of them show exactly the same behaviour: 'ls -l' via  telnet
blocks also. I could get a 635 byte file via ftp, but fetching a
69294 bytes long file stalled. (This time, strace shows that ftpd is
sitting in write(5, ...data..., 56262), and there are
13032 bytes in Send-Q for ftpd...)

So what is this? Seems that there's a general TCP I/O problem with
the software current software versions in Debian unstable. libc
problem? Could a lousy network card cause this? Are there any
debugging hints for me?

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
