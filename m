Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUIPMAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUIPMAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUIPL60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:58:26 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:12213 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268037AbUIPL57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:57:59 -0400
Subject: Re: Suspend2 Merge: e820 table support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916113735.GG5467@elf.ucw.cz>
References: <1095332590.3324.166.camel@laptop.cunninghams>
	 <20040916111438.GB5467@elf.ucw.cz>
	 <1095333881.4932.194.camel@laptop.cunninghams>
	 <20040916112711.GD5467@elf.ucw.cz>
	 <1095334545.4932.206.camel@laptop.cunninghams>
	 <20040916113735.GG5467@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095335962.5006.241.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:59:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 21:37, Pavel Machek wrote:
> Hi!
> 
> > > Hmm, it also contains (saveable()):
> > > 
> > >         BUG_ON(PageReserved(page) && PageNosave(page));
> > 
> > How do you cover those HighMem pages that get marked Reserved and are
> > unusable? (That's what the e820 logic was for, iirc. Think it was done
> > about February!). Not handling them resulted in MCEs when trying to do
> > the atomic copy or when restoring (seemed random).
> 
> This function is not use for highmem, AFAICS. If page is marked
> reserved we do not touch it. Do you suggest that we need to save it
> for highmem case?

I love trying to remember things from six months ago. Will have to look
at the email from around then and get back to you.

> MCEs... I see you have patch to disable them during suspend... That's
> clearly wrong thing to do, right?

Yes, we shouldn't need to disable them if we have above right. I'll test
removing that with some of the people who had MCE issues.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

