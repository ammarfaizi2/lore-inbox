Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130966AbRAaJMP>; Wed, 31 Jan 2001 04:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRAaJMF>; Wed, 31 Jan 2001 04:12:05 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:34054 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130966AbRAaJLw>; Wed, 31 Jan 2001 04:11:52 -0500
Message-ID: <3A77D6A3.309A656F@idb.hist.no>
Date: Wed, 31 Jan 2001 10:10:59 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <200101310008.f0V08Wv23250@localhost.localdomain> <3A775FEB.D7614D98@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Christopher Neufeld wrote:
> 
> >  The only patch
> > which has to be applied to make Linux run stably on these systems is to
> > increase that limit.  Would it be possible to bump it up to 128, or even
> > 256, in later 2.4.* kernel releases?  That would allow this customer to
> > work with an unpatched kernel, at the cost of an additional 3.5 kB of
> > variables in the kernel.
> 
> I guess the cleanest solution would be to allow variable setting of the
> maximum number of PCI busses in the config file, similar to the
> CONFIG_UNIX98_PTY_COUNT setting, so that "exotic" users with 32+ PCI
> busses can boost the standard value according to their needs, without
> having to increase kernel size for the normal users.
> 
Wouldn't autodetection be the better solution?  Seems to me the kernel
has
no problem detecting all the buses, so why not break the probing into a
two-
pass thing - first pass simply counts buses, second pass allocate memory
and fills in the arrays.  
(One-pass is possible too, if dynamic allocation is possible at this
time.)
No config option to worry about, no excess room for 32 buses on ordinary
pc's, no worry for the 100-bus user.


Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
