Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTFTTnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 15:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTFTTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 15:43:07 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:29648 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264537AbTFTTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 15:43:04 -0400
Date: Fri, 20 Jun 2003 21:56:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au,
       dwmw2@infradead.org
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
Message-ID: <20030620195658.GB22732@wohnheim.fh-wedel.de>
References: <20030620185915.GD28711@wohnheim.fh-wedel.de> <20030620.124510.28800472.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030620.124510.28800472.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 June 2003 12:45:10 -0700, David S. Miller wrote:
>    From: Jörn Engel <joern@wohnheim.fh-wedel.de>
>    Date: Fri, 20 Jun 2003 20:59:15 +0200
>    
>    The whole interface of the bzlib was modelled after the zlib
>    interface.
> 
> The zlib interface is actually problematic, it doesn't allow
> handling of scatter-gather lists on input or output for example.
> 
> Therefore we couldn't make the compress cryptolib interface
> take scatterlists elements either, which is a huge problem.

Is there a reason to use the zlib and nothing but the zlib for the
cryptolib?  RFCs 1950 - 1952?  Or would any form of compression do, in
principle at least?

In the worst case, I consider it not too hard to add a wrapper
interface to the zlib to do the scatter-gather handling.  Actually
going deeply into the guts of the zlib is not good for a kernel
hackers sanity though.  The massive use of macros with magic knowledge
of the surrounding functions is - well - interesting.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
