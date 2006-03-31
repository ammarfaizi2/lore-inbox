Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWCaUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWCaUER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCaUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:04:16 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:9763 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932266AbWCaUEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:04:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmXhgFLGZS4uYaqIo5U8dmtC38i8sjHj7gNj4AD/wF9VGOUjcozwy40Eols6uLxHzZOwEurdKpWoRS+H5zyqwwzVA47OH7P/Z7FRXrOiGSbkMoWI4BSPkQJkf/m38dxd6Cfe9+4TGk3CHRym+IFy6awcar3IS5TPAbePaoCj1ME=
Message-ID: <c0a09e5c0603311204k6b64842bm741d3e7726b39e77@mail.gmail.com>
Date: Fri, 31 Mar 2006 12:04:13 -0800
From: "Andrew Grover" <andy.grover@gmail.com>
To: "Ingo Oeser" <netdev@axxeo.de>
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Cc: "Kumar Gala" <galak@kernel.crashing.org>,
       "Chris Leech" <christopher.leech@intel.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <200603311026.33391.netdev@axxeo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060329225505.25585.30392.stgit@gitlost.site>
	 <c0a09e5c0603301036s4e9a63e5v476d89ff8ba37760@mail.gmail.com>
	 <351C5BDA-D7E3-4257-B07E-ABDDCF254954@kernel.crashing.org>
	 <200603311026.33391.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/06, Ingo Oeser <netdev@axxeo.de> wrote:
> Kumar Gala wrote:
> > Fair, but wouldn't it be better to have the association per client.
> >
> > Maybe leave the one as a summary and have a dir per client with
> > similar stats that are for each client and add a per channel summary
> > at the top level as well.
> Such level of detail really belongs to debugging, IMHO.
[snip]

If we implemented more stats then yes debugfs sounds like it might be
the way to go.

> BTW: What is the actual frequency, at which such counters
> will be incremented?

Currently the code updates these variables (kept per cpu) every time a
copy is queued. See include/linux/dmaengine.h.

-- Andy
