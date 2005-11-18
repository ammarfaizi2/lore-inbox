Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVKRBN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVKRBN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVKRBN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:13:27 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:10387 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751318AbVKRBN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:13:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ab7AfV+Z0brEbophicRyNGevjCfLOjcfoHer597g802rRJX1adSu1IIEiNwW75ND46S0arzDZm26bNDoxYAZvLJIE+Kyqysf7QTNwCG7s41xwMIH4pIKRQQ0pywY2NvpGxykSJhiJGThT9gg6PWoAgmids2fISNVIgmNyOjhQcQ=
Message-ID: <35fb2e590511171713p159695casde2bed085f6f0368@mail.gmail.com>
Date: Fri, 18 Nov 2005 01:13:26 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: ipt_ROUTE loopback
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051117043853.GH11266@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590511161901t7a615992s123a22cd8403511d@mail.gmail.com>
	 <20051117043853.GH11266@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Willy Tarreau <willy@w.ods.org> wrote:

> You missed this page...  :-)

Excellent, as I hoped.

> You need to use Julian Anastasov's "send-to-self" patch from ssi.bg/~ja/.
> The problem is not with ipt_route, but with the local addresses. If you
> want the packet to go out, you need to remove the local route for the
> destination. The packet will then go out, but when it will come back,
> the system won't take it because its destination won't match a local
> route. Try "ip r l t local" to see what I mean.

Yes. But the ROUTE target could also do this if I hacked up its route
function. I realised the problem was in the local routing table (as I
mentioned earlier) but it looks like this patch will save me
re-implementing yet another wheel.

Cheers,

Jon.
