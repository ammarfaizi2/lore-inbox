Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbRGFI2F>; Fri, 6 Jul 2001 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266293AbRGFI1p>; Fri, 6 Jul 2001 04:27:45 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37821 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266292AbRGFI1f>;
	Fri, 6 Jul 2001 04:27:35 -0400
Message-ID: <3B457661.67EABAFE@mandrakesoft.com>
Date: Fri, 06 Jul 2001 04:27:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Ville Nummela <ville.nummela@mail.necsom.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: tasklets in 2.4.6
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com> <3B45760D.6F99149C@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> > --- 2.4.6pre5/include/asm-alpha/softirq.h       Thu Jun 21 08:03:51 2001
> > +++ softirq/include/asm-alpha/softirq.h Thu Jun 21 15:58:06 2001
> > @@ -8,21 +8,28 @@
> >  extern inline void cpu_bh_disable(int cpu)
> >  {
> >         local_bh_count(cpu)++;
> > -       mb();
> > +       barrier();
> >  }
> >
> > -extern inline void cpu_bh_enable(int cpu)
> > +extern inline void __cpu_bh_enable(int cpu)
> >  {
> > -       mb();
> > +       barrier();
> >         local_bh_count(cpu)--;
> >  }
> 
> I do not say this is wrong... but why reinvent the wheel?  Is it
> possible to use atomic_t for local

ignore this.  I see the reason, and forgot to delete this text :)

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
