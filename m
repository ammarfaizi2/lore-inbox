Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270451AbUJTTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270451AbUJTTjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270442AbUJTTb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:31:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:47560 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270432AbUJTTaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:30:15 -0400
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 PageAnon bug
References: <BFECAF9E178F144FAEF2BF4CE739C66818F59A@exmail1.se.axis.com.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0410201542140.9192-100000@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Oct 2004 21:27:39 +0200
In-Reply-To: <Pine.LNX.4.44.0410201542140.9192-100000@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p738ya1yytw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:
 
> But what does "aligned(2)" or "aligned(4)" do on 64-bit machines -
> any danger of it aligning stupidly?  I think not, but know little.

It will align stupidly. 

This means on x86-64 i don't care too much because the misalignment
penalty on K8 is only 1 cycle and not that much worse on P4, but 
others may care more.

-Andi
 
