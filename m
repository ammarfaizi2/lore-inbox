Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTEaS1k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTEaS1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:27:40 -0400
Received: from vitelus.com ([64.81.243.207]:518 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S264403AbTEaS1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:27:37 -0400
Date: Sat, 31 May 2003 11:40:23 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "David S. Miller" <davem@redhat.com>
Cc: wli@holomorphy.com, alexander.riesen@synopsys.COM, scrosby@cs.rice.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Message-ID: <20030531184023.GA14878@vitelus.com>
References: <20030531063040.GI8978@holomorphy.com> <20030530.233353.28798744.davem@redhat.com> <20030531064138.GJ8978@holomorphy.com> <20030530.234529.88485326.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530.234529.88485326.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 11:45:29PM -0700, David S. Miller wrote:
>    From: William Lee Irwin III <wli@holomorphy.com>
>    Date: Fri, 30 May 2003 23:41:38 -0700
>    
>    If it's literally that trivial I'll put digging around the machine
>    descriptions on my TODO list.
> 
> Look at TARGET_RTX_COSTS, thats where all of this happens.

Reading the code that handles this stuff (expmed.c) always cracks me up.


  /* We might want to refine this now that we have division-by-constant
     optimization.  Since expand_mult_highpart tries so many variants, it is
     not straightforward to generalize this.  Maybe we should make an array
     of possible modes in init_expmed?  Save this for GCC 2.7.  */
 
        /* We could just as easily deal with negative constants here,
           but it does not seem worth the trouble for GCC 2.6.  */

        /* This is extremely similar to the code for the unsigned case
           above.  For 2.7 we should merge these variants, but for
           2.6.1 I don't want to touch the code for unsigned since that
           get used in C.  The signed case will only be used by other
           languages (Ada).  */

Sometimes I wish the gcc code was tame enough for me to work on.
