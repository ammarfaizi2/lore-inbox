Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTEaGRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTEaGRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:17:32 -0400
Received: from holomorphy.com ([66.224.33.161]:29075 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264152AbTEaGRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:17:31 -0400
Date: Fri, 30 May 2003 23:30:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: alexander.riesen@synopsys.COM, scrosby@cs.rice.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Message-ID: <20030531063040.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, alexander.riesen@synopsys.COM,
	scrosby@cs.rice.edu, linux-kernel@vger.kernel.org
References: <oyd3cixc9ev.fsf@bert.cs.rice.edu> <20030529.232440.122068039.davem@redhat.com> <20030530085901.GB11885@Synopsys.COM> <20030530.020040.52897577.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530.020040.52897577.davem@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Riesen <alexander.riesen@synopsys.COM>
Date: Fri, 30 May 2003 10:59:01 +0200
>        static
>        int hash_3(int hi, int c)
>        {
>    	return (hi + (c << 4) + (c >> 4)) * 11;
>        }
>    gcc-3.2.1 -O2 -march=pentium
>  ...   
>    It is not guaranteed to be this way on all architectures, of course.
>    But still - no multiplications.

On Fri, May 30, 2003 at 02:00:40AM -0700, David S. Miller wrote:
> Indeed, I'd missed this.  GCC will emit the constant multiply
> expansion unless the multiply cost is set VERY low.

If the strength reduction situation changes to being properly handled
by gcc for most/all 64-bit arches, include/linux/hash.h can lose a #ifdef.


-- wli
