Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265515AbRGEXUM>; Thu, 5 Jul 2001 19:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265534AbRGEXUC>; Thu, 5 Jul 2001 19:20:02 -0400
Received: from pop.gmx.net ([194.221.183.20]:23990 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265515AbRGEXTu>;
	Thu, 5 Jul 2001 19:19:50 -0400
Date: Thu, 5 Jul 2001 19:31:06 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705193105.A600@marvin.mahowi.de>
Mail-Followup-To: Andrew Morton <andrewm@uow.edu.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B448684.8355DB69@uow.edu.au>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.6 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Fri, 06 Jul 2001, Andrew Morton wrote:

> > Okay, here's the output of gdb:
> > 
> > (gdb) x/10i 0xc0118028
> > 0xc0118028 <bh_action>: mov    0x4(%esp,1),%eax
> > 0xc011802c <bh_action+4>:       cmpl   $0x0,0xc025c2e4
> > 0xc0118033 <bh_action+11>:      jne    0xc0118043 <bh_action+27>
> > 0xc0118035 <bh_action+13>:      mov    0xc024af20(,%eax,4),%eax
> > 0xc011803c <bh_action+20>:      test   %eax,%eax
> > 0xc011803e <bh_action+22>:      je     0xc0118042 <bh_action+26>
> > 0xc0118040 <bh_action+24>:      call   *%eax
> > 0xc0118042 <bh_action+26>:      ret
> > 0xc0118043 <bh_action+27>:      lea    (%eax,%eax,4),%eax
> > 0xc0118046 <bh_action+30>:      lea    0xc025bf80(,%eax,4),%eax
> > 
> 
> Well I guess it tells us it's not random uninitialised
> crud.
> 
> Just for interest: what happens if you swap around the lines
> 
>         time_init();
>         softirq_init();
> 
> in init/main.c?
> 

That works, kernel boots now without problems.

Thanks,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or "http://www.mahowi.de/pgp/mahowi.asc"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | AIM: mahowi42   * ICQ: 61597169
