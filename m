Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281179AbRKLXTS>; Mon, 12 Nov 2001 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKLXTK>; Mon, 12 Nov 2001 18:19:10 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:8888 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281177AbRKLXSx>; Mon, 12 Nov 2001 18:18:53 -0500
Message-ID: <007501c16bd0$36d93a20$0a00a8c0@intranet.mp3s.com>
Reply-To: "Sean Elble" <S_Elble@yahoo.com>
From: "Sean Elble" <S_Elble@yahoo.com>
To: "Don Krause" <dkrause@optivus.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <015f01c16bbe$bd5272e0$6cc8c58f@satoy>
Subject: Re: Is ReiserFS stable?
Date: Mon, 12 Nov 2001 18:17:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problems that you may see with NFS-exported file systems on Linux tend
to be symbolic link problems and the such, at least in later kernels. Reiser
only compounds these problems even further. In my experiences, NFS always
seems to work well with Solaris boxes; the problems I have seen personally
are with my IRIX box. Even without Reiser, I've had a couple problems, but
they have been gone since 2.4.10 . . . havn't tried Reiser since then
though. Good luck moving your home directories to Reiser . . . not too hard
of a move, though I'd have to recommend XFS myself. :-)

-----------------------------------------------
Sean P. Elble
Editor, Writer, Co-Webmaster
ReactiveLinux.com (Formerly MaximumLinux.org)
http://www.reactivelinux.com/
elbles@reactivelinux.com
-----------------------------------------------

----- Original Message -----
From: "Don Krause" <dkrause@optivus.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, November 12, 2001 4:12 PM
Subject: RE: Is ReiserFS stable?


> Actually, while I had major problems with reiser and nfs in the stock SuSE
> 6.4 kernel,
> I have a very busy nfs server running SuSE 6.4 with a custom compiled
2.4.2
> kernel and
> all available (at the time..) reiser +nfs patches, that moves on the order
> of 6 million
> files per day, with no problems. (Small files, but this same system
crashed
> consistently every
> 30 days or so with the stock kernel)
>
> And to make things worse, this box exports to a Sun 1000e,
> running 2.6
>
> ankaa:~ # uptime
>   1:33pm  up 194 days, 22:31,   1 user,   load average: 0.00, 0.00, 0.00
> ankaa:~ # uname -a
> Linux ankaa 2.4.2 #1 Thu Apr 19 07:34:27 PDT 2001 i586 unknown
>
> (No load, this is a backup database server, and backups don't run monday
> mornings..)
>
> Because of the success of this server, I'll be switching our home
> directories to reiser over the next couple months.
>
>
> --
> Don Krause                                       ph: 909.799.8327
> Systems Administrator                          page: 909.512.0174
> Optivus Technology, Inc               e-mail: dkrause@optivus.com
> "Splitting Atoms.. Saving Lives"           http://www.optivus.com
>
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Sean Elble
> > Sent: Sunday, November 11, 2001 9:51 AM
> > To: Roy Sigurd Karlsbakk; linux-kernel@vger.kernel.org
> > Subject: Re: Is ReiserFS stable?
> >
> >
> > That all depends on what you mean by "stable". Reiser
> > is certainly capable of high uptimes, but Reiser
> > doesn't have a good history of working well with older
> > UNIX tools/systems like NFS, due to Reiser's newer
> > methods for handling inodes and such. If this isn't a
> > problem for you, Reiser should work very well for you;
> > it works great on my /var partition, which handles my
> > Squid proxy. I don't use Reiser on my /home partition
> > though; that FS has the user directories exported
> > through NFS, as well as Samba. In fact, I use SGI's
> > XFS on my /home partition, and that works well too.
> > The main advantage to using XFS is that it handles NFS
> > _really_ well, and it has certain features Reiser
> > doesn't, like extended attributes, and access control
> > lists. YMMV, but Reiser seems stable for just that one
> > specific duty . . . I'd recommend trying Reiser, JFS,
> > XFS, and maybe even Ext3 to get a feel for how stable
> > each is for your particular needs. HTH.
> > --- Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
> > > Hi all
> > >
> > > I've heard a lot of talk from all sorts of people
> > > about ReiserFS not being
> > > stable enough to use in a productional environment
> > > where high uptime is
> > > essensial.
> > >
> > > Can someone tell me if this is true?
> > >
> > > Thanks
> > >
> > > roy
> > >
> > > --
> > > Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> > >
> > > Computers are like air conditioners.
> > > They stop working when you open Windows.
> > >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

