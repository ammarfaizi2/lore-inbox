Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbTCaVcS>; Mon, 31 Mar 2003 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbTCaVcR>; Mon, 31 Mar 2003 16:32:17 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:25534 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261866AbTCaVcQ>; Mon, 31 Mar 2003 16:32:16 -0500
Date: Mon, 31 Mar 2003 23:02:51 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331230251.F626@nightmaster.csn.tu-chemnitz.de>
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331052214.GV13178@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030331052214.GV13178@holomorphy.com>; from wli@holomorphy.com on Sun, Mar 30, 2003 at 09:22:14PM -0800
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *190746-0000At-00*u9LRCJTlqFE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,
hi Andrea,

On Sun, Mar 30, 2003 at 09:22:14PM -0800, William Lee Irwin III wrote:
> Miscellaneous side effects happen, like follow_page() and
> get_user_pages() need to return pfn's instead of struct pages.

Hmm, but you know, that users of get_user_pages() play games with
pages? They need to lock them into memory, mark them eventually
dirty, map them to a struct scatterlist and much more.

I worked on an API (I called it the page-walk-api), to make this
more and more transparent. 

So if this work will go into 2.6.x, then the page-walk-API will
be needed, or else the driver writers playing tricks with
virtual<->physical<->bus address conversions will go nuts.

So which kernel is the target of this development?

Regards

Ingo Oeser
