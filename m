Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293683AbSB1TJu>; Thu, 28 Feb 2002 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293133AbSB1TIz>; Thu, 28 Feb 2002 14:08:55 -0500
Received: from ns.caldera.de ([212.34.180.1]:55760 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S293700AbSB1TH7>;
	Thu, 28 Feb 2002 14:07:59 -0500
Date: Thu, 28 Feb 2002 20:07:30 +0100
Message-Id: <200202281907.g1SJ7Ul16828@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: andrea@suse.de (Andrea Arcangeli)
Cc: linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: vm-28 for 2.4.19pre1
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20020228174607.X1705@inspiron.school.suse.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

In article <20020228174607.X1705@inspiron.school.suse.de> you wrote:
> This patch includes all my latest VM developement against 2.4.19pre1. I
> would suggest it for inclusion in pre2. I don't have the time right now
> to split it into little pieces, but I can do that in the weekend or next
> week if you prefer (tomorrow I'll be offline).
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre1/vm-28

Could you actually explain what it changes, especially as it isn't
really commented very well..

Despite of the above I already have some nitpicks:

 - couldn't you make inc_nr_active_pages/dec_nr_active_pages/
	inc_nr_inactive_pages/dec_nr_inactive_pages inlines?
   The current macro abuse isn't nice.
 - in mm/memory.c (the 1141 chunk) you introduced a race.


-- 
Of course it doesn't work. We've performed a software upgrade.
