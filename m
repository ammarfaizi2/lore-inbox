Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269692AbRHIGbZ>; Thu, 9 Aug 2001 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269698AbRHIGbO>; Thu, 9 Aug 2001 02:31:14 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14860 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S269692AbRHIGbF>; Thu, 9 Aug 2001 02:31:05 -0400
Message-ID: <3B722DE4.96DA5711@idb.hist.no>
Date: Thu, 09 Aug 2001 08:29:56 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Ivan Kalvatchev <iive@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch2] Re: DoS with tmpfs #3
In-Reply-To: <20010808171702.57332.qmail@web13603.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kalvatchev wrote:

> I didn't look at the chages but i will say this one
> more time. Limiting tmpfs size at fixed amount of
> space will make the bug harder to reproduce but won't
> fix it. The right hack is to limit tmpfs to be with
> freepages.high less than available memory(swap+ram).
> It won't be hard to code.

The problem with this is that tmpfs may be mounted before
swap is initialized, so a little less than
swap+ram will become "a little less than just RAM" anyway.

Or do you propose a dynamic limit, changing as swap
is added/removed?  This has problems if some swap is
removed, and suddenly tmpfs usage exceeds its quota.

Helge Hafting
