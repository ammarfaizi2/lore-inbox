Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVJ1QCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVJ1QCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVJ1QCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:02:51 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:1264 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030234AbVJ1QCu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:02:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hF7pTJxGGEAB61KShVJIUH2XHNF3ZN/9TjvGFsoliHBpIJuk9+hMX7VMngHETqn3Z1/p5x3MSGSPiMnuDbKmOWtFKGEwcE5WO3wWRT0MH5hDivxAwl5/rXzQmeaDtxWVxw3hDV6TmTEUesD0+HH41begY6OPYW8ITiqeI3qxgvc=
Message-ID: <39e6f6c70510280902q30b43634nc68324a371d7d910@mail.gmail.com>
Date: Fri, 28 Oct 2005 14:02:50 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: "hawkes@sgi.com" <hawkes@sgi.com>
Subject: Re: [PATCH] 2.6.14-rc4: wider use of for_each_*cpu() in net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051013190133.13192.46039.sendpatchset@tomahawk.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051013190133.13192.46039.sendpatchset@tomahawk.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, hawkes@sgi.com <hawkes@sgi.com> wrote:
> In 'net' change the explicit use of for-loops and NR_CPUS into the
> general for_each_cpu() or for_each_online_cpu() constructs, as
> appropriate.  This widens the scope of potential future optimizations
> of the general constructs, as well as takes advantage of the existing
> optimizations of first_cpu() and next_cpu(), which is advantageous
> when the true CPU count is much smaller than NR_CPUS.
>
> Signed-off-by: John Hawkes <hawkes@sgi.com>

Thanks, applied and pushed to Linus,

- Arnaldo
