Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVB1AJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVB1AJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVB1AJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:09:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261523AbVB1AG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:06:27 -0500
Date: Sun, 27 Feb 2005 19:06:18 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christian Schmid <webmaster@rapidforum.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
In-Reply-To: <42225B34.7020104@rapidforum.com>
Message-ID: <Pine.LNX.4.61.0502271905270.19979@chimarrao.boston.redhat.com>
References: <4221FB13.6090908@rapidforum.com>
 <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com>
 <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com>
 <422239A8.1090503@rapidforum.com> <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com>
 <42225B34.7020104@rapidforum.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Christian Schmid wrote:

> No i am only using 4 tasks with Poll-API and non-blocking sockets. Every
> socket gets a 1 MB read-ahead. This are 4000 MB Max on a 8 GB machine....
> Shouldnt thrash.

If nothing else on the system uses any memory, and there
were no memory zones and no division into active and
inactive memory.

You may want to try a smaller readahead window and see if
your system still has trouble with the load.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
