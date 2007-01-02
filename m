Return-Path: <linux-kernel-owner+w=401wt.eu-S1755404AbXABU1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbXABU1W (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbXABU1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:27:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:2560 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbXABU1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:27:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=D6TRsyCMPmzb6DKMuvHs3XITT4xPFHooqDzZlvnhyEUfNhu+sX7205c1lICRK/ua+Uyg3YF/+aXFYoSbaOljIErXetOcoVJlJONiyUxWY/mD81DIyEPbTgHIwsqCVtFa0PSDij3mqkA/PqXsJ7cqQiZ4jCWonZsrao9MtIu1Qq8=
Message-ID: <84144f020701021227x17c4b866ne39ebe4501afece6@mail.gmail.com>
Date: Tue, 2 Jan 2007 22:27:19 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH] slab: cache alloc cleanups
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
In-Reply-To: <Pine.LNX.4.64.0701020822230.15611@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701021545290.21477@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0701020822230.15611@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: 1888751bd3ed2567
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Pekka J Enberg wrote:
> > +
> > +     if (nodeid == -1 || nodeid == numa_node_id()) {
> > +             if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
> > +                     obj = alternate_node_alloc(cache, flags);
> > +                     if (obj)
> > +                             goto out;
> > +             }

On 1/2/07, Christoph Lameter <clameter@sgi.com> wrote:
> This reintroduces a bug that was fixed a while ago.

Aah, well, we could have a can_mempolicy parameter, but I'm not sure
if it's an improvement to the current version still...
