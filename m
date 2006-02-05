Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWBEQjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWBEQjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 11:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWBEQjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 11:39:49 -0500
Received: from imladris.surriel.com ([66.92.77.98]:21965 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S1750835AbWBEQjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 11:39:49 -0500
Date: Sun, 5 Feb 2006 11:39:43 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Shantanu Goel <sgoel01@yahoo.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
In-Reply-To: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0602051138260.26086@imladris.surriel.com>
References: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: 
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Shantanu Goel wrote:

> It seems rotate_reclaimable_page fails most of the
> time due the page not being on the LRU when kswapd
> calls writepage().

The question is, why is the page not yet back on the
LRU by the time the data write completes ?

Surely a disk IO is slow enough that the page will
have been put on the LRU milliseconds before the IO
completes ?

In what kind of configuration do you run into this
problem ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
