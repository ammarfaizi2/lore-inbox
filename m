Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTIXR0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTIXR0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:26:34 -0400
Received: from [209.195.52.120] ([209.195.52.120]:32986 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261552AbTIXR0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:26:32 -0400
From: David Lang <david.lang@digitalinsight.com>
To: John Bradford <john@grabjohn.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, rjohnson@analogic.com
Date: Wed, 24 Sep 2003 10:22:41 -0700 (PDT)
Subject: Re: Horiffic SPAM
In-Reply-To: <200309241645.h8OGjS9i000412@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0309241020570.6808@dlang.diginsite.com>
References: <200309241645.h8OGjS9i000412@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

correct, but the origional poster attempted to solve the problem at the
network layer, not at the SMTP layer, also while some of the virus engines
will not retry in the face of 400 series errors, if you have a backup MX
configured that accepts it and relays it to you that machine will retry.

my point (and I think part of yours as well) is that you need to block
this at the application layer, not the network layer

David Lang

 On Wed, 24 Sep 2003, John
Bradford wrote:

> Date: Wed, 24 Sep 2003 17:45:28 +0100
> From: John Bradford <john@grabjohn.com>
> To: david.lang@digitalinsight.com, john@grabjohn.com
> Cc: andrea@suse.de, linux-kernel@vger.kernel.org, rjohnson@analogic.com
> Subject: Re: Horiffic SPAM
>
> > if you want to block mail you need to have your MTA return a 500 series
> > error code when it gets a connection from that IP address, otherwise the
> > sending MTA will just retry later, resulting in the problem described.
>
> Read my post again.
>
> A lot of the simple SMTP engines embedded in viruses _don't_ retry on
> 4xx error codes.  Real SMTP engines do.
>
> That flaw is what we are taking advantage of, to filter out the junk.
>
> I.E. we tell everybody 'come back later'.  Genuine mail does, whilst
> junk mail often doesn't bother.
>
> John.
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
