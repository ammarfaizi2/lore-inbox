Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbREFAIL>; Sat, 5 May 2001 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135532AbREFAIA>; Sat, 5 May 2001 20:08:00 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:1806 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S130768AbREFAHo>; Sat, 5 May 2001 20:07:44 -0400
Message-ID: <3AF4961B.F23C9948@zk3.dec.com>
Date: Sat, 05 May 2001 20:08:59 -0400
From: Peter Rival <frival@zk3.dec.com>
X-Mailer: Mozilla 4.6 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
In-Reply-To: <20010505063726.A32232@va.samba.org> <3AF4118F.330C3E86@zk3.dec.com> <20010506033746.A30690@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

> On Sat, May 05, 2001 at 10:43:27AM -0400, Peter Rival wrote:
>
>     Has anyone looked into memory hot swap/hot add support?
>
> Adding memory probably isn't going to be too hard... but taking
> existing memory off line is tricky. You have to find some way of
> finding all the pages that are in use and then dealing with them
> appropriately, and when some are locked or contain kernel data this
> would be extremely difficult I should think.
>

Hrmm...  I agree this is a hard problem.  I know people smarter than I have
been thinking about this type of problem at Compaq.  While I haven't talked to
them directly, my only guess would be that we'd have to hand-rewrite some page
tables after copying the page contents to a new area.  It's late Saturday and
I really haven't thought this through fully, so I'm not even sure that would
work, but it's something like how we support replicated text segments on our
GS series...don't know why it wouldn't work here.  *shrug*

>     Especially with systems with Chipkill coming out, this would be
>     great to support...
>
> Chipkill?
>

It's the IBM technology that works around bad memory by detecting single-bit
errors and removing the chip that caused it from use.  I'd think of this as a
big hammer version of that in software.  Besides, eventually you'll want to
replace the DIMM that has the bad chip, and what better way then while the
system is still running (as long as it's stable, of course ;)  I'm just
thinking out loud, so someone can correct me if I'm being loopy...

 - Pete

