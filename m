Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTDSVCD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTDSVCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:02:03 -0400
Received: from web41804.mail.yahoo.com ([66.218.93.138]:35494 "HELO
	web41804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263465AbTDSVCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:02:02 -0400
Message-ID: <20030419211356.25316.qmail@web41804.mail.yahoo.com>
Date: Sat, 19 Apr 2003 14:13:56 -0700 (PDT)
From: Christian Staudenmayer <eggdropfan@yahoo.com>
Subject: Re: 2.5.67-ac2 and lilo
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030419205152.GA19800@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andries,

before taking your message into account, i think you misunderstood my
question:

> Hmm. You did not forget to rerun LILO or so?

the error occurs when _running_ lilo, i.e. after typing "lilo" at the prompt.

greetings, chris

--- Andries Brouwer <aebr@win.tue.nl> wrote:
> > but now, when running lilo, i get the following message:
> > 
> > Fatal: First boot sector doesn't have a valid LILO signature
> 
> Hmm. You did not forget to rerun LILO or so?
> If ide_xlate_1024 does nothing but "return 0" then
> handle_ide_mess() does nothing.
> 
> What other differences does -ac2 have?
> It reintroduces a bug in the partition reading code - the fragment
> 
> @@ -456,7 +556,7 @@
>                 if (!subtypes[n].parse)
>                         continue;
>                 subtypes[n].parse(state, bdev, START_SECT(p)*sector_size,
> -                                               NR_SECTS(p)*sector_size, slot);
> +                                               NR_SECTS(p)*sector_size, n);
>         }
>         put_dev_sector(sect);
> 
> of the -ac2 patch is bad.
> In order to judge whether it is this or something else I would have
> to know much more about your system. What are the kernel boot messages
> for this disk under 2.5.67-bk9 that works and 2.5.67-ac2 that fails?
> What is the partition table? No disk managers in sight? Does LILO
> have lba32 or linear options?
> Does 2.5.67-ac2 work if you replace its fs/partitions/msdos.c by
> the vanilla one?
> 
> Andries
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
