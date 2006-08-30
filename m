Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWH3Vn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWH3Vn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWH3Vn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:43:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58884 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932137AbWH3Vn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:43:58 -0400
Date: Wed, 30 Aug 2006 23:43:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060830214356.GO18276@stusta.de>
References: <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F5DA00.8050909@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 08:33:36PM +0200, Stefan Richter wrote:
> Roman Zippel wrote:
> >On Tue, 29 Aug 2006, Stefan Richter wrote:
> >>An easy but crude fix would be to add an according hint at the help text 
> >>of
> >>the immediately superordinate config option.
> [...]
> >You can also add a simple comment which is only visible if !SCSI.
> 
> Thanks, I will do so.

Please don't do this.

USB_STORAGE switched from a depending on SCSI to select'ing SCSI three 
years ago, and ATA in 2.6.19 will also select SCSI for a good reason:

When doing anything kconfig related, you must always remember that the 
vast majority of kconfig users are not kernel hackers.

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

