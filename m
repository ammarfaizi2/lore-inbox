Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWF1XlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWF1XlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWF1XlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:41:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:32394 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751782AbWF1XlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:41:06 -0400
X-Authenticated: #704063
Date: Thu, 29 Jun 2006 01:41:02 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Russ Cox <rsc@swtch.com>
Cc: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Message-ID: <20060628234102.GB28463@alice>
References: <1151535167.28311.1.camel@alice> <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com> <20060628231627.GA28463@alice> <ee9e417a0606281624t23f5ccc2qd095b9bf993a0861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9e417a0606281624t23f5ccc2qd095b9bf993a0861@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17-mm3 (i686)
X-Uptime: 01:32:24 up 15:26,  7 users,  load average: 1.11, 0.97, 0.94
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russ Cox (rsc@swtch.com) wrote:
> >If this is whats agreed upon I will no longer send patches for
> >such bugs, and mark them as ignore in the coverity system.
> >But I guess it makes also sense to remove unused code, because I
> >am not sure if gcc can figure out to remove it. In this case
> >the generated object file is 10 bytes smaller.
> 
> I wasn't necessarily speaking for the group so much as I was interested
> in how coverity was being used and what the rules were.
> Thanks for the info.

guess thats depends on the person looking trough the bugs :)
As far as i know, there are no official rules ( except maybe
to never let gregkh see a false positive :), i just try to
take a look at the coverity reports, and fix whatever I can,
in cleanup cases like this it clearly depends on the maintainer,
what he does with the patch. the coverity guys seem to be pretty
nice in giving accounts away, so you might want to take a look
at this stuff yourself. At the moment about half of the inspected
"bugs" have been marked as invalid or false, to shut coverity up
about clearly defensive programming or false analysis, so i guess
the main part is not to make coverity shut up with a patch, since
marking it as invalid is much less hassle.

Eric

