Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSIXXGS>; Tue, 24 Sep 2002 19:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbSIXXGS>; Tue, 24 Sep 2002 19:06:18 -0400
Received: from nameservices.net ([208.234.25.16]:948 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261836AbSIXXGS>;
	Tue, 24 Sep 2002 19:06:18 -0400
Message-ID: <3D90F20E.405769B0@opersys.com>
Date: Tue, 24 Sep 2002 19:15:26 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Jacob Gorm Hansen <jg@ioi.dk>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Adeos-main] Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch 
 code
References: <3D8E8371.D2070D87@opersys.com> <20020922045907.C35@toy.ucw.cz> <3D90D388.746D0C0D@opersys.com> <20020924213356.GA14291@ibook>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jacob Gorm Hansen wrote:
> On Tue, Sep 24, 2002 at 05:05:12PM -0400, Karim Yaghmour wrote:
> >
> > To be honest, nothing in Adeos is "new". Adeos is implemented on
> > classic early '90s nanokernel research. I've listed a number of
> > nanokernel papers in the paper I wrote on Adeos. A complete list
> > of nanokernel papers would probably have hundreds of entries.
> > Some of these nanokernels even had OS schedulers (exokernel for
> > instance). All Adeos implements is a scheme for sharing the
> > interrupts among the various OSes using an interrupt pipeline.
> 
> Hi,
> 
> are you planning to add spaces & portals, like in Space or Pebble?

I'm not sure whether what we plan to offer actually fits Space's definition
of spaces, but domains already exist and portals should be trivial to
implement over what we already have. For details on what plan to offer
in terms of spaces, take a look at the paper I wrote describing how
to implement Linux SMP clusters:
http://opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
Basically, Adeos would hand over RAM regions according to each OS
instance's requests. In such a case, each kernel would have its own
virtual memory and communication would be possible using "bridges",
shared physical RAM regions. Many OSes can coexist in the same virtual
address space, but the mechanisms for managing the virtual address
space are not up to Adeos.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
