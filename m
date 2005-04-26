Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVDZPKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVDZPKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDZPKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:10:05 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:2983 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261564AbVDZPJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TaRR5KZekTxUMKzB2PYdLCOC1Oq+RJfsG8UiD/HABMkLJW93SYcOfIq9KSsUYrp/NRhiK+wkpAvcmiy9OANQhN9hjYJrRSpX3baL7GTEqCBDtZ7L41gR1Aeu9W4gpHtEcmrruNNHmOslzj16DMmB8iKGIC4h+1wtKnHXtAZ/li0=
Message-ID: <aec7e5c305042608095731d571@mail.gmail.com>
Date: Tue, 26 Apr 2005 17:09:52 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Chris Mason <mason@suse.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Cc: Linus Torvalds <torvalds@osdl.org>, Mike Taht <mike.taht@timesys.com>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
In-Reply-To: <200504260713.26020.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050426004111.GI21897@waste.org>
	 <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org>
	 <200504260713.26020.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Chris Mason <mason@suse.com> wrote:
> This agrees with my tests here, the time to apply patches is somewhat disk
> bound, even for the small 100 or 200 patch series.  The io should be coming
> from data=ordered, since the commits are still every 5 seconds or so.

Yes, as long as you apply the patches to disk that is. I've hacked up
a small backend tool that applies patches to files kept in memory and
uses a modifed rabin-karp search to match hunks. So you basically read
once and write once per file instead of moving data around for each
applied patch. But it needs two passes.

And no, the source code for the entire Linux kernel is not kept in
memory - you need a smart frontend to manage the file cache. Drop me a
line if you are interested.

/ magnus
