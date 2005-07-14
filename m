Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVGNNuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVGNNuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbVGNNut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:50:49 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:40659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261396AbVGNNur convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:50:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kNJ2AwyGlG338hbwHhQmymMYQqriCfC5aq1muszLzz6aJdTNDMPb592M/mJeQC8vv2A0r912c3th9j7jJDVlnMDwDeG2u3Pzg1lhHyEERyXRYQBIjdRUeuC2A5qzJs0Kel1IMucEgG6p6wA7OyeyPgm0BGOTmTYbOEa0rmwq1H8=
Message-ID: <60868aed050714065047e3aaec@mail.gmail.com>
Date: Thu, 14 Jul 2005 16:50:01 +0300
From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: XFS corruption on move from xscale to i686
Cc: linux-xfs@oss.sgi.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, tibor@altlinux.ru, pakhuchiy@iptel.by
In-Reply-To: <20050714012048.GB937@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1120756552.5298.10.camel@pc299.sam-solutions.net>
	 <20050708042146.GA1679@frodo>
	 <60868aed0507130822c2e9e97@mail.gmail.com>
	 <20050714012048.GB937@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/14, Nathan Scott <nathans@sgi.com>:
> On Wed, Jul 13, 2005 at 06:22:28PM +0300, Yura Pakhuchiy wrote:
> > I found patch by Greg Ungreger to fix this problem, but why it's still
> > not in mainline? Or it's a gcc problem and should be fixed by gcc folks?
> 
> Yes, IIRC the patch was incorrect for other platforms, and it sure
> looked like an arm-specific gcc problem (this was ages back, so
> perhaps its fixed by now).

AFAIR gcc-3.4.3 was released after this conversation take place at linux-xfs,
maybe add something like this:

#ifdef XSCALE
    /* We need this because some gcc versions for xscale are broken. */
    [patched version here]
#else
    [original version here]
#endif

Best regards,
        Yura
