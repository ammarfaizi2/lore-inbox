Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317961AbSGWG1o>; Tue, 23 Jul 2002 02:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317965AbSGWG1o>; Tue, 23 Jul 2002 02:27:44 -0400
Received: from [196.26.86.1] ([196.26.86.1]:36294 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317961AbSGWG1o>; Tue, 23 Jul 2002 02:27:44 -0400
Date: Tue, 23 Jul 2002 08:48:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <Pine.LNX.4.44.0207221004420.2504-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207230845070.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Linus Torvalds wrote:

> As to needing to do a save without a disable, show me where that really
> matters..

Heres an interesting one;

void setup_APIC_timer(void * data)
{
	[...]
        __save_flags(flags);
        __sti();
	[...]
}

Regards,
	Zwane
-- 
function.linuxpower.ca

