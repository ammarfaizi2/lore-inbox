Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUHLA67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUHLA67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUHLAxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:53:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51409 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268470AbUHLAS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:18:58 -0400
Date: Thu, 12 Aug 2004 02:18:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>,
       wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040812001848.GW26174@fs.tum.de>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de> <Pine.LNX.4.58.0408112223140.20634@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408112223140.20634@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 11:45:21PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Wed, 11 Aug 2004, Adrian Bunk wrote:
> 
> > Roman, is it intentional that PCMCIA!=n is true if there's no PCMCIA 
> > option, or is it simply a bug?
> 
> Yes, undefined symbols have a (string) value of "" . Maybe it's time to 
> add a warning for such comparisons...

is there any strong reason why undefined symbols aren't equivalent to 
symbols with a value of "n"?

Many !=n seems to be bogus (especially ones from the automatic 
transition to the new Kconfig) and I'll audit them. But rewriting valid 
FOO!=n to (FOO=y || FOO=m) doesn't sound like an improvement.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

