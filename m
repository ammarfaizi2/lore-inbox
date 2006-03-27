Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWC0Vie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWC0Vie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWC0Vid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:38:33 -0500
Received: from anubis.pendulus.net ([38.119.36.60]:54710 "EHLO
	anubis.pendulus.net") by vger.kernel.org with ESMTP
	id S1751469AbWC0Vic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:38:32 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
Date: Mon, 27 Mar 2006 16:38:33 -0500
User-Agent: KMail/1.9.1
Cc: "Wu Fengguang" <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
References: <20060319023413.305977000@localhost.localdomain> <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
In-Reply-To: <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603271638.34260.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We use lighttpd on our servers, and I can say with 100% that this problem 
happens alot. Because of this , we were forced to use to userspace mechanism 
that the lighttpd author made to cirvumvent this issue. However with this 
patch, I'm unable to produce any of the problems we had experienced before. 
IO-Wait has dropped significantly from 80% to 20%. 
I'd be happy to send over some benchmarks if need be.

Matt Heler

On Saturday 18 March 2006 10:10 pm, Jon Smirl wrote:
> This is probably a readahead problem. The lighttpd people that are
> encountering this problem are not regular lkml readers.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=5949
>
> --
> Jon Smirl
> jonsmirl@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
