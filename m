Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTLON1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTLON1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:27:40 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:34244 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263568AbTLON1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:27:40 -0500
Date: Mon, 15 Dec 2003 14:26:21 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: Vladimir Saveliev <vs@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031215132621.GB1286@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <200312121535.22375.rob@landley.net> <1071482402.11042.36.camel@tribesman.namesys.com> <200312150552.22805.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312150552.22805.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 December 2003 05:52:22 -0600, Rob Landley wrote:
> 
> The earlier suggestion I was disagreeing with would automatically create holes 
> in any file that wrote a sufficiently large range of zero bytes.  Hence the 
> cache poisoning and general defeating the purpose of DMA and such.  Neither 
> truncate, nor a punch syscall, would mess with the normal "write" path 
> (beyond locking so write and truncate/punch didn't stomp each other).

And the suggestor remains convinced that this is a good idea.  It
would be perfectly ok to defer actually looking at the data to later,
move that functionality to a journald or gcd or so, but the principle
mains unchanged.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
