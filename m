Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266457AbRGFMHV>; Fri, 6 Jul 2001 08:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266476AbRGFMHL>; Fri, 6 Jul 2001 08:07:11 -0400
Received: from pop.gmx.net ([194.221.183.20]:12207 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S266457AbRGFMG7>;
	Fri, 6 Jul 2001 08:06:59 -0400
Date: Fri, 6 Jul 2001 12:58:47 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010706125846.A590@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010705114633.A1787@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.6 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2001, Arjan van de Ven wrote:

> On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> > And the winner is... Andrea. Kudos to you, I've just applied these patches,
> > recompiled and it seems to work fine.
> > Too bad, this was the perfect excuse for getting rid of those good old Cyrix
> > boxen ;)
> 
> As Andrea's patches don't actually fix anything Cyrix related it's obvious
> that they just avoid the real bug instead of fixing it.
> It's a very useful datapoint though.

For me, it works with just swapping around these two lines

         time_init();
         softirq_init();

in init/main.c. Thanks, Andrew, for this tip.

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or "http://www.mahowi.de/pgp/mahowi.asc"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | AIM: mahowi42   * ICQ: 61597169
