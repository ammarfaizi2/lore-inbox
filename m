Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWH0S1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWH0S1L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWH0S1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:27:10 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:9390 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932237AbWH0S1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:27:09 -0400
Date: Sun, 27 Aug 2006 20:27:08 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Message-ID: <20060827182708.GB12642@rhlx01.fht-esslingen.de>
References: <20060827084417.918992193@goop.org> <20060827172155.GA21724@rhlx01.fht-esslingen.de> <200608272004.38280.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608272004.38280.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 27, 2006 at 08:04:38PM +0200, Andi Kleen wrote:
> 
> > Something like that had to be done eventually about the inefficient
> > current_thread_info() mechanism, 
> 
> Inefficient? It's two fast instructions. I won't call that inefficient.

And that AGI stall?

> > I guess it's due to having tried that on an older installation with gcc 3.2,
> > which probably does less efficient opcode merging of current_thread_info()
> > requests compared to a current gcc version.
> 
> gcc normally doesn't merge inline assembly at all.

Depends on use of volatile, right?

OK, so probably there was no merging of separate requests,
but opcode intermingling could have played a role.

Andreas Mohr
