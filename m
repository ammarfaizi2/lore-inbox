Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932279AbWFDWDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWFDWDQ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWFDWDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:03:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:34770 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932279AbWFDWDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:03:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XXFx+Vqe7Du362LE6JJi8S4DxUYpa602MWAj50rBHhhFugnIwB+yzbGI/W2JoCwYCbgG3cavYwP7NVUG7EIWVELxsC/TncbyVLAaiI71u2PW556TshFhvvinb8O3cA+AYXrqQFzWyTcyjmQ8bKzGqGBgMv8C1lzGuC+ll+DYlX8=
Message-ID: <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com>
Date: Sun, 4 Jun 2006 15:03:12 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Cc: Valdis.Kletnieks@vt.edu, "Andrew Morton" <akpm@osdl.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <20060604213432.GB5898@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
	 <20060604133326.f1b01cfc.akpm@osdl.org>
	 <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu>
	 <20060604213432.GB5898@elte.hu>
X-Google-Sender-Auth: a2ee12d0ae2c8818
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Ingo Molnar <mingo@elte.hu> wrote:
> nevertheless i'll turn that warning into a less scary message.

This discussion seems to imply that I reported a false positive... is
it *known* that I reported a false positive, or is it only a strong
possibility?

Assuming it's a false positive: Since this stops the tracer, it means
that if an actual deadlock possibility is detected later [I'm assuming
that detection of those doesn't get shut down by the bad-lock-ordering
detection either], useful information could be missing from
/proc/latency_trace, if I am not mistaken. Perhaps this could impede
lockdep testing for people running reiser4 filesystems. I guess this
is just a theoretical possibility at this point, but perhaps it's
worth mentioning.
-- 
-Barry K. Nathan <barryn@pobox.com>
