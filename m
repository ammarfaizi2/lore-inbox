Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVK1T26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVK1T26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVK1T26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:28:58 -0500
Received: from hera.kernel.org ([140.211.167.34]:36743 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932202AbVK1T25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:28:57 -0500
Date: Mon, 28 Nov 2005 11:46:43 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: s_maxbytes on isofs for 2.4
Message-ID: <20051128134643.GB25081@logos.cnet>
References: <200511272123.jARLNeA03057@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511272123.jARLNeA03057@apps.cwi.nl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries,

On Sun, Nov 27, 2005 at 10:23:40PM +0100, Andries.Brouwer@cwi.nl wrote:
> I got a problem report on the handling of large (2.4GB) files
> with isofs, where 2.6 was fine and 2.4 failed. Replied
> 
> >I suspect that the difference between 2.4 and 2.6 is the assignment
> >       s->s_maxbytes = 0xffffffff;
> >in isofs/inode.c. Could you try to add that after
> >       s->s_magic = ISOFS_SUPER_MAGIC;
> >in the 2.4 source?
> 
> and got the confirmation that that solves the problems.
> Maybe one should consider adding this in 2.4.
> No, I have not audited the source. If in fact there is
> a reason why files this size are not handled correctly,
> there should probably be an assignment with the largest
> value that is handled correctly, together with a comment.

My knowledge is quite limited, but I can't spot any issues with 
files upto 4GB. Who was the reporter?

Yes, suppose we could include it if there is interest to confirm safety.

