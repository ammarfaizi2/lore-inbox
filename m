Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129422AbRBMP7J>; Tue, 13 Feb 2001 10:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbRBMP7A>; Tue, 13 Feb 2001 10:59:00 -0500
Received: from ns.suse.de ([213.95.15.193]:7952 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129422AbRBMP6n>;
	Tue, 13 Feb 2001 10:58:43 -0500
Date: Tue, 13 Feb 2001 16:58:31 +0100
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
Message-ID: <20010213165831.A1289@suse.de>
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com> <shsbss8i8iq.fsf@charged.uio.no> <20010212111448.A28932@suse.de> <20010212125115.B30552@suse.de> <3A881FA7.2C5C8CBE@transmeta.com> <20010212184816.C3778@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212184816.C3778@suse.de>; from olh@suse.de on Mon, Feb 12, 2001 at 06:48:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, Olaf Hering wrote:

> On Mon, Feb 12, H. Peter Anvin wrote:
> 
> > Olaf Hering wrote:
> > > 
> > > The autofs4.o is the culprit, it works perfect with autofs.o.
> > > 
> > > What would happen if I stick with autofs.o now?
> > > The docu recommends autofs4 in modules.conf.
> > > 
> > 
> > I don't know who came up with that idea.  You should use the module that
> > matches your daemon, and not try to hack around so that there is a
> > module/daemon mismatch.
> 
> cantaloupe:~ # /usr/sbin/automount -v 
> Linux automount version 4.0.0
> 
> 
> We had 4.0pre7 in 7.0 and 4.0pre9 in 7.1.
> I would really like to know _where_ it hangs, Trond sent me a printk
> patch but this one was not called. 

Any ideas where to start with the debugging?


> I will try to get a i386 SMP machine to see if its ppc specific.

I'm unable to reproduce it on a Piii 750 with SuSE 7.1.

guillory:/usr/src/OLAF/linux-2.4.2-pre3 # sh scripts/ver_linux 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux guillory 2.4.2-pre3-SMP #3 SMP Tue Feb 13 14:50:47 CET 2001 i686
unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.0.33
Linux C Library        x    1 root     root      1382179 Jan 19 07:14
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10q
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         nfsd ipv6 mousedev hid input usbcore eepro100


both 2.4.1ac10 and 2.4.2-pre3 boot fine.

This machine oops in the usb stack, but thats another issue.



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
