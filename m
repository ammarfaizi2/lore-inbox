Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSAZRU7>; Sat, 26 Jan 2002 12:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSAZRUw>; Sat, 26 Jan 2002 12:20:52 -0500
Received: from zok.SGI.COM ([204.94.215.101]:52963 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S284144AbSAZRUi>;
	Sat, 26 Jan 2002 12:20:38 -0500
Date: Sat, 26 Jan 2002 09:19:20 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ingo's O(1) scheduler vs. wait_init_idle
Message-ID: <20020126091920.A6303@sgi.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201241020230.4694-100000@localhost.localdomain> <154900000.1011894435@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154900000.1011894435@flay>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 09:47:15AM -0800, Martin J. Bligh wrote:
> >> I was trying to test this in my 8 way NUMA box, but this patch seems
> >> to have lost half of the wait_init_idle fix that I put in a while
> >> back. [...]

We had this same trouble on 4 to 12 way Itanium machines, but finally
made them boot using a variation of your fix.  That was with J7.  It
looks like the boot cpu gets stuck waiting for wait_init_idle to
clear.  We'll try to send out a patch on Monday.

Thanks,
Jesse
