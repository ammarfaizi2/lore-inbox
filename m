Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVBGVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVBGVCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBGVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:02:44 -0500
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:34225 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261284AbVBGVCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:02:33 -0500
Subject: Re: 2.6.11-rc2-mm1
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1107797420.24154.25.camel@localhost>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124121729.GA29392@infradead.org>  <20050207115736.GB22948@elte.hu>
	 <1107797420.24154.25.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 16:02:00 -0500
Message-Id: <1107810120.12971.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2005.2.7.5
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 12:30 -0500, Robert Love wrote:
> Well, I don't share the hatred for ioctl, at least compared to another
> type unsafe interface like write().
> 
> But John and I are open to doing whatever is the consensus.  If there is
> an agreed alternative, and that is the requirement for merging, I'll do
> it.

Yes, if ioctl is unacceptable, then providing a write() interface is
what we will do.

> 
> I'd like to keep the user-space interface and simple, and absolutely
> want to keep the single file descriptor approach.  How the fd is
> obtained is up for discussion.

I would still like to keep the character device as the interface for
getting the fd. I don't see what benefit could be gained by converting
to a syscall based interface for getting the fd.

-- 
John McCutchan <ttb@tentacle.dhs.org>
