Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280995AbRKLVNB>; Mon, 12 Nov 2001 16:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280992AbRKLVMw>; Mon, 12 Nov 2001 16:12:52 -0500
Received: from proton.llumc.edu ([143.197.200.1]:23806 "EHLO proton.llumc.edu")
	by vger.kernel.org with ESMTP id <S280990AbRKLVMj>;
	Mon, 12 Nov 2001 16:12:39 -0500
From: "Don Krause" <dkrause@optivus.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Is ReiserFS stable?
Date: Mon, 12 Nov 2001 13:12:27 -0800
Message-ID: <015f01c16bbe$bd5272e0$6cc8c58f@satoy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20011111175053.96626.qmail@web11701.mail.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, while I had major problems with reiser and nfs in the stock SuSE
6.4 kernel,
I have a very busy nfs server running SuSE 6.4 with a custom compiled 2.4.2
kernel and
all available (at the time..) reiser +nfs patches, that moves on the order
of 6 million
files per day, with no problems. (Small files, but this same system crashed
consistently every
30 days or so with the stock kernel)

And to make things worse, this box exports to a Sun 1000e,
running 2.6

ankaa:~ # uptime
  1:33pm  up 194 days, 22:31,   1 user,   load average: 0.00, 0.00, 0.00
ankaa:~ # uname -a
Linux ankaa 2.4.2 #1 Thu Apr 19 07:34:27 PDT 2001 i586 unknown

(No load, this is a backup database server, and backups don't run monday
mornings..)

Because of the success of this server, I'll be switching our home
directories to reiser over the next couple months.


--
Don Krause                                       ph: 909.799.8327
Systems Administrator                          page: 909.512.0174
Optivus Technology, Inc               e-mail: dkrause@optivus.com
"Splitting Atoms.. Saving Lives"           http://www.optivus.com


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Sean Elble
> Sent: Sunday, November 11, 2001 9:51 AM
> To: Roy Sigurd Karlsbakk; linux-kernel@vger.kernel.org
> Subject: Re: Is ReiserFS stable?
>
>
> That all depends on what you mean by "stable". Reiser
> is certainly capable of high uptimes, but Reiser
> doesn't have a good history of working well with older
> UNIX tools/systems like NFS, due to Reiser's newer
> methods for handling inodes and such. If this isn't a
> problem for you, Reiser should work very well for you;
> it works great on my /var partition, which handles my
> Squid proxy. I don't use Reiser on my /home partition
> though; that FS has the user directories exported
> through NFS, as well as Samba. In fact, I use SGI's
> XFS on my /home partition, and that works well too.
> The main advantage to using XFS is that it handles NFS
> _really_ well, and it has certain features Reiser
> doesn't, like extended attributes, and access control
> lists. YMMV, but Reiser seems stable for just that one
> specific duty . . . I'd recommend trying Reiser, JFS,
> XFS, and maybe even Ext3 to get a feel for how stable
> each is for your particular needs. HTH.
> --- Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
> > Hi all
> >
> > I've heard a lot of talk from all sorts of people
> > about ReiserFS not being
> > stable enough to use in a productional environment
> > where high uptime is
> > essensial.
> >
> > Can someone tell me if this is true?
> >
> > Thanks
> >
> > roy
> >
> > --
> > Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> >
> > Computers are like air conditioners.
> > They stop working when you open Windows.
> >

