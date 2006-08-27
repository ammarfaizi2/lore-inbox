Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWH0SXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWH0SXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWH0SXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:23:19 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:11689 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932233AbWH0SXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:23:18 -0400
Date: Sun, 27 Aug 2006 20:23:17 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Message-ID: <20060827182317.GA12642@rhlx01.fht-esslingen.de>
References: <20060827084417.918992193@goop.org> <20060827172155.GA21724@rhlx01.fht-esslingen.de> <44F1D7B6.80105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F1D7B6.80105@goop.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 27, 2006 at 10:34:46AM -0700, Jeremy Fitzhardinge wrote:
> Andreas Mohr wrote:
> >This is interesting, since even by doing a non-elegant
> >current->... --> struct task_struct *tsk = current;
> >replacement for excessive uses of current, I was able to gain almost 10kB
> >within a single file already!
> >I guess it's due to having tried that on an older installation with gcc 
> >3.2,
> >which probably does less efficient opcode merging of current_thread_info()
> >requests compared to a current gcc version.
> >IOW, .text segment reduction could be quite a bit higher for older gcc:s.
> >  
> 
> That doesn't sound likely.  current_thread_info() is only about 2 
> instructions.  Are you looking at the .text segment size, or the actual 
> file size?  The latter can be very misleading in the presence of debug info.

Got me. File size only. And that was 10kB of around 170kB, BTW.

Andreas Mohr
