Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWJTJU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWJTJU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWJTJU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:20:29 -0400
Received: from holoclan.de ([62.75.158.126]:20611 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S2992592AbWJTJU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:20:28 -0400
Date: Fri, 20 Oct 2006 11:17:53 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: un/shared IRQ problem (was: Re: 2.6.18 - another DWARF2)
Message-ID: <20061020091753.GC5709@gimli>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061017063710.GA27139@gimli> <4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com> <20061018063431.GE20238@gimli> <20061018232603.585d14c3.akpm@osdl.org> <20061019063921.GJ6189@gimli> <20061019000109.626170f7.akpm@osdl.org> <m1mz7s5plh.fsf@ebiederm.dsl.xmission.com> <20061019101411.f2466b2e.akpm@osdl.org> <20061020083741.GA5709@gimli> <20061020014753.4d568ddc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020014753.4d568ddc.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Fri, Oct 20, 2006 at 01:47:53AM -0700, Andrew Morton
	wrote: > On Fri, 20 Oct 2006 10:37:41 +0200 > Martin Lorenz
	<martin@lorenz.eu.org> wrote: > > > > > the new ones are in > >
	http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty.run
	> >
	http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty.boot
	> > Confused. I see no backtraces in the above. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:47:53AM -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2006 10:37:41 +0200
> Martin Lorenz <martin@lorenz.eu.org> wrote:
> 
> > 
> > the new ones are in 
> > http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty.run
> > http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty.boot
> 
> Confused.  I see no backtraces in the above.

only the ones I copied below
so the original issue of this thread seems to be solved in the 2.6.19-rc2


> 
> > http://www.lorenz.eu.org/~mlo/kernel/interrupts_2.6.19-rc2-tp-ie-e1-42.5+0737-gce9e3d99-dirty
> > is there too
> > 
> > http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D
> > for a list of files I uploaded
> > 
> > [   64.655000] kobject_add failed for vcs6 with -EEXIST, don't try to register things with the same name in the same directory.
> > [   64.655000]  [<c0103bfd>] dump_trace+0x69/0x1af
> > [   64.655000]  [<c0103d5b>] show_trace_log_lvl+0x18/0x2c
> > [   64.656000]  [<c01043fa>] show_trace+0xf/0x11
> > [   64.656000]  [<c01044fd>] dump_stack+0x15/0x17
> > [   64.656000]  [<c01fbf3d>] kobject_add+0x160/0x189
> > [   64.657000]  [<c0250fec>] class_device_add+0xa2/0x3d8
> > [   64.658000]  [<c02513ae>] class_device_create+0x7c/0x9c
> > [   64.659000]  [<c0237858>] vcs_make_sysfs+0x3c/0x7e
> > [   64.659000]  [<c023c641>] con_open+0x6f/0x7c
> > [   64.660000]  [<c023259b>] tty_open+0x179/0x2f0
> > [   64.661000]  [<c016226e>] chrdev_open+0x124/0x13f
> > [   64.662000]  [<c015e665>] __dentry_open+0xc7/0x1ab
> > [   64.662000]  [<c015e7c3>] nameidata_to_filp+0x24/0x33
> > [   64.662000]  [<c015e804>] do_filp_open+0x32/0x39
> > [   64.663000]  [<c015e84d>] do_sys_open+0x42/0xc3
> > [   64.663000]  [<c015e907>] sys_open+0x1c/0x1e
> > [   64.664000]  [<c0102de7>] syscall_call+0x7/0xb
> > [   64.664000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> 
> hm, people report that occasionally - I don't think anyone knows what's
> causing it.
> 
so I'll simply ignore it :-)


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
