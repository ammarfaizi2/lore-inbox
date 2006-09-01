Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWIANrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWIANrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWIANry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:47:54 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:49076 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751469AbWIANrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:47:53 -0400
Date: Fri, 1 Sep 2006 15:44:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060901134425.GA32440@wohnheim.fh-wedel.de>
References: <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1157074048.2347.24.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 August 2006 18:27:27 -0700, David Woodhouse wrote:
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

Coming from you, the Aunt Tillie argument doesn't make more sense than
it did coming from ESR.

The actual problem existed before select just as it does afterwards.
People have to search extensively though Kconfig files to come up with
a useful .config.  Before people had to magically know that
USB_STORAGE requires SCSI.  "Magically" because USB_STORAGE didn't
show up in either make menuconfig, make xconfig or .config.  Now
people have to magically know that SCSI=n requires USB_STORAGE=n.
You have the exact same problem and it has nothing to do with Aunt
Tillie.

What this shows is that select was a bad idea, as it merely shifted
the problem around instead of fixing it.  It appears as if Stefan is
looking in the right direction for a decent fix and I'd like to see
patches from him.  If only to stop these bad analogies ESR tried to
argue with. :)

Jörn

-- 
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus
