Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273857AbRI0USe>; Thu, 27 Sep 2001 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273877AbRI0USY>; Thu, 27 Sep 2001 16:18:24 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:49930 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S273857AbRI0UST>; Thu, 27 Sep 2001 16:18:19 -0400
Message-ID: <3BB2065E.B0BAE05F@eisenstein.dk>
Date: Wed, 26 Sep 2001 18:46:22 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Klaus Dittrich <kladit@t-online.de>
CC: linux-kernel@vger.kernel.org, klaus@df1tlb.local.here
Subject: Re: 2.4.10 and dd
In-Reply-To: <200109272002.WAA02203@df1tlb.local.here>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:

> I do my backup using dd if=/dev/sda of=/dev/sdb bs=1024k.

ehh, isn't that kind of dangerous???

What if files move around on disk while dd is running? imagine that dd is in the process of copying blocks belonging to a big file "foo",
and now in the middle of this something causes "foo" (or just parts of "foo") to move to a different location - you now have a seriously screwed
copy of "foo" on the new disk...

I'd expect that all sorts of strange corruption of the copy could happen that way. I could be wrong, and maybe someone who knows more about
how the filesystems work can tell if I am, but I know for sure that I would never dare to do backups that way.

Best regards,
Jesper Juhl
juhl@eisenstein.dk



