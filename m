Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTE3OxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTE3OxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:53:12 -0400
Received: from cs.rice.edu ([128.42.1.30]:25343 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S263738AbTE3OxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:53:10 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alexander.riesen@synopsys.COM, linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
References: <oyd3cixc9ev.fsf@bert.cs.rice.edu>
	<20030529.232440.122068039.davem@redhat.com>
	<20030530085901.GB11885@Synopsys.COM>
	<20030530.020040.52897577.davem@redhat.com>
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 30 May 2003 10:05:51 -0500
In-Reply-To: <20030530.020040.52897577.davem@redhat.com>
Message-ID: <oydd6i04gq8.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-DCC--Metrics: cs.rice.edu 1066; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 02:00:40 -0700 (PDT), "David S. Miller" <davem@redhat.com> writes:

>    From: Alex Riesen <alexander.riesen@synopsys.COM>
>    Date: Fri, 30 May 2003 10:59:01 +0200
> 
>        static
>        int hash_3(int hi, int c)
>        {
>    	return (hi + (c << 4) + (c >> 4)) * 11;
>        }
>    
>    gcc-3.2.1 -O2 -march=pentium
>  ...   
>    It is not guaranteed to be this way on all architectures, of course.
>    But still - no multiplications.
> 
> Indeed, I'd missed this.  GCC will emit the constant multiply
> expansion unless the multiply cost is set VERY low.

It may still be a win. This does a bit under a dozen instructions per
byte. However, jenkin's does many bytes at a time.

Scott
