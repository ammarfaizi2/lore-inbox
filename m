Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVESCZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVESCZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 22:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVESCZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 22:25:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262451AbVESCZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 22:25:31 -0400
Date: Wed, 18 May 2005 22:25:25 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
In-Reply-To: <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Linus Torvalds wrote:

> Why not just change the "addr >= len" test into "addr > len" and be done 
> with it?

If you're fine with not catching dereferences of a struct
member further than PAGE_SIZE into a struct when the struct
pointer is NULL, sure ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
