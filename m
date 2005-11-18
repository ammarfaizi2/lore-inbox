Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVKRVIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVKRVIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKRVIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:08:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932197AbVKRVIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:08:35 -0500
Date: Fri, 18 Nov 2005 16:08:00 -0500
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
Message-ID: <20051118210800.GB28205@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>,
	"David S. Miller" <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com> <20051117.155230.25121238.davem@davemloft.net> <437D6AD0.5080909@yahoo.com.au> <20051117.224516.118147408.davem@davemloft.net> <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 08:02:02AM +0000, Hugh Dickins wrote:

 > No, that was not too hasty: we all agreed that the case _ought_ not to
 > arise, and we hadn't worked out the right code to handle it if it did
 > arise.  What was disappointing is that nobody hit the warnings while
 > it was in -mm, but only when it hit Linus' tree.

It was found quite quickly though.  Fedora rawhide tracks Linus'
-git trees on an almost daily basis, and this change blew up
the installer, so it wasn't hard to reproduce :)

ddcprobe isn't something that a lot of people run on a daily basis
(probably just the installer people, and they never see -mm kernels),
but I'm surprised that vbetool didn't get spotted when it was in -mm,
as more and more people seem to be trying out suspend/resume these days.

Maybe suspend was busted for some other reason at the time it
was in -mm, so people never got that far ?

		Dave

