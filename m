Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271299AbTGWWpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271371AbTGWWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:45:30 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:33242 "HELO
	develer.com") by vger.kernel.org with SMTP id S271299AbTGWWpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:45:24 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Date: Thu, 24 Jul 2003 01:00:00 +0200
User-Agent: KMail/1.5.9
Cc: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>,
       David McCullough <davidm@snapgear.com>
References: <200307232046.46990.bernie@develer.com> <200307240035.38502.bernie@develer.com> <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307240100.00632.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 July 2003 00:37, Alan Cox wrote:

> On Mer, 2003-07-23 at 23:35, Bernardo Innocenti wrote:
> > It's a sequence of 6 instructions, 18 bytes long, clobbering 4 registers.
> > The compiler cannot see around it.
> > This takes 18*11 = 198 bytes just for invoking the 'current'
> > macro so many times.
>
> Unless you support SMP I'm not sure I understand why m68k nommu changed
> from using a global for current_task ?

The people who might know best are Greg and David from SnapGear.
I'm appending them to the Cc list.

But I noticed that most archs in 2.6 do like this. Is it some kind
of flock-effect? Things get changed in i386 and all other archs
just follow... :-)

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


