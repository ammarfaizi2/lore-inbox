Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSJCBdh>; Wed, 2 Oct 2002 21:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSJCBdh>; Wed, 2 Oct 2002 21:33:37 -0400
Received: from pool-129-44-58-33.ny325.east.verizon.net ([129.44.58.33]:62729
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S261530AbSJCBdg>; Wed, 2 Oct 2002 21:33:36 -0400
Date: Wed, 2 Oct 2002 21:38:59 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Message-ID: <20021002213859.A27014@arizona.localdomain>
References: <Pine.LNX.4.44.0210012219460.21087-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210012219460.21087-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Oct 01, 2002 at 10:29:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 10:29:02PM +0200, Ingo Molnar wrote:
> On Tue, 1 Oct 2002, Linus Torvalds wrote:
> > Pease don't introduce more typedefs. They only hide what the hell the
> > thing is, which is actively _bad_ for structures, since passing a
[...]
> Despite all the previous fuss about the problems of typedefs, i've never
> had *any* problem with using typedefs in various code i wrote. It only
> ever made things cleaner - to me.

Hi Ingo,

I follow your reasoning, but one thing I don't follow -

+typedef struct work_s {
+       unsigned long pending;
+       struct list_head entry;
+       void (*func)(void *);
+       void *data;
+       void *wq_data;
+       timer_t timer;
+} work_t;

- why two names for the structure ("struct work_s" and "work_t")?

Either convention will work, but by declaring the structure twice it only
encourages users to employ their own favorite - thus defeating the purpose
of a convention.

Just curious,
-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
