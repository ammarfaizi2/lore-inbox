Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSEXXkl>; Fri, 24 May 2002 19:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313038AbSEXXkk>; Fri, 24 May 2002 19:40:40 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:28677 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S312681AbSEXXkj>; Fri, 24 May 2002 19:40:39 -0400
Date: Fri, 24 May 2002 16:40:33 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC - named loop devices...
Message-ID: <20020524164033.B9600@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020521015517.609d5516.spyro@armlinux.org> <200205211409.g4LE9HY31513@Port.imtp.ilyichevsk.odessa.ua> <20020523180105.141af04b.spyro@armlinux.org> <20020523180453.E29960@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 06:04:53PM +0100, Russell King wrote:
> On Thu, May 23, 2002 at 06:01:05PM +0100, Ian Molton wrote:
> > On Tue, 21 May 2002 17:11:34 -0200
> > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> > 
> > > > I was wondering if a solution to this would be to introduce 'named'
> > > > loopback devices.
> > 
> > > Have no time to think about this now, but will test any patches -
> > > I want /etc/mtab -> /proc/mounts to become standard practice
> > 
> > me too. :-)
> 
> /proc/mounts and /etc/mtab contain different information.  /etc/mtab can
> contain what ever information a user space app needs.  /proc/mount can't.
> See the following as a perfect example, specifically the automount and
> NFS entries.
> 
> Also, remember that mount uses /etc/mtab to perform synchronisation
> between two concurrent mount requests for the same device/resource.
> 
[snip]

It is clear to me that what really needs to happen is to
retire /etc/mtab.  It seems to be the last file in /etc that
needs to be written.  Mount, df and others need to look
elsewhere and we might need a syscall (if it doesn't exist)
to support umount and root pivoting when not even proc is
mounted.  It might be a pain to coordinate but should be
worth it.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
