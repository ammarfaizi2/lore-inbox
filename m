Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTBJI3j>; Mon, 10 Feb 2003 03:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTBJI3j>; Mon, 10 Feb 2003 03:29:39 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:59911 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264715AbTBJI3h>; Mon, 10 Feb 2003 03:29:37 -0500
Date: Mon, 10 Feb 2003 08:39:17 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: torvalds@transmeta.com, LA Walsh <law@tlinx.org>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030210083917.A16926@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>, torvalds@transmeta.com,
	LA Walsh <law@tlinx.org>, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org> <3E471F21.4010803@wirex.com> <20030210082140.A16436@infradead.org> <3E4763C8.5090100@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E4763C8.5090100@wirex.com>; from crispin@wirex.com on Mon, Feb 10, 2003 at 12:33:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 12:33:12AM -0800, Crispin Cowan wrote:
> Am I parsing this correctly, that we actually agree on something? :-) 
> I.e. that the idea of moving all the security logic to a module has merit.

Yes.  If we want so support security models more complicated than plain
UNIX DAC (an especially more than one of those) there's no way around
moving all access control out of the core kernel.

> Naturally, I disagree that we should remove the current LSM. The current 
> version was designed to be what Linus asked for. Many LSM people like 
> the idea of moving all the security logic out to a module, as it makes 
> the interface much cleaner. But it is also waaay beyond the scope of 
> what Linus asked for. It involves re-factoring so much code that we did 
> not think it could be done correctly on the first try, never mind trying 
> to get many code maintainers to accept much larger patches.

Well, usually adding changes to the core kernel in a proper way needs
major refactoring of code - the approach of adding a small, "non-invasive"
hack here and there leads to the typical mess seen in commercial operating
systems, and in Linux we've avoided that mostly so far.

As far keeping the current LSM hooks:  I'm very unhappy with the design
of the, that's one point.  The other point I'm extremly unhappy with
adding them without adding it's users.  I'll shut up and be quite until
2.7 opens if you get a meaningfull LSM module merged that actually uses
those hooks.  If you don't get one in by 2.6-test I will send patches
to remove those unused hooks.

