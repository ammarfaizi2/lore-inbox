Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbSJLUJV>; Sat, 12 Oct 2002 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSJLUJV>; Sat, 12 Oct 2002 16:09:21 -0400
Received: from are.twiddle.net ([64.81.246.98]:31919 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261342AbSJLUJU>;
	Sat, 12 Oct 2002 16:09:20 -0400
Date: Sat, 12 Oct 2002 13:15:01 -0700
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, wli@holomorphy.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [lart] /bin/ps output
Message-ID: <20021012131501.C25740@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, anton@samba.org,
	wli@holomorphy.com, haveblue@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20021012035141.GC7050@krispykreme> <20021012035958.GD10722@holomorphy.com> <20021012040959.GE7050@krispykreme> <20021011.235329.116353173.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021011.235329.116353173.davem@redhat.com>; from davem@redhat.com on Fri, Oct 11, 2002 at 11:53:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 11:53:29PM -0700, David S. Miller wrote:
> In fact, thinking about this some more, we should make the ".per_cpu"
> bits emit a table entry instead of some dummy object which takes up
> space.  The table entry would be in the special .per_cpu
> section still but be just a size value.

That's more complicated.  Using the linker to help out with
layout is definitely helpful.  If you want to omit the per-cpu
area from the kernel image, then arrange for it to be .bss.


r~
