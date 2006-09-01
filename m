Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWIABrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWIABrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWIABrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:47:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12048 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964881AbWIABrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:47:05 -0400
Date: Fri, 1 Sep 2006 03:47:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060901014702.GZ18276@stusta.de>
References: <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157074048.2347.24.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 06:27:27PM -0700, David Woodhouse wrote:
> On Thu, 2006-08-31 at 17:48 -0700, Randy.Dunlap wrote:
> > But David, you edit .config anyway, so who is "make *config" for?
> > Not that I want enable Tillie very much.. 
> 
> I edit .config but still have to use 'make oldconfig' afterwards. And it
> screws me over because of all this 'select' nonsense. This used to
> work...
> 	sed -i /^CONFIG_SCSI=/d .config 
> 	yes n | make oldconfig
> 
> So "make *config" certainly isn't optimised for me, although of course I
> do have to use it. It seems to be increasingly optimised for Aunt
> Tillie.

The vast majority of konfig user who might have a master in computer 
science (like our Aunt Tillie has) but aren't kernel hackers have 
different needs from kernel hackers.

I know how hard it is to e.g. find a maximum .config with FW_LOADER=n.

Normal kconfig users and kernel hackers have different needs, and the 
real solution fitting the needs of both groups would in this case be
a patch to kconfig that allows a kernel hacker to specify which option 
to deselect and does the rest automatically.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

