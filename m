Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVEZNb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVEZNb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVEZNb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:31:28 -0400
Received: from mout1.freenet.de ([194.97.50.132]:39566 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261396AbVEZNbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:31:25 -0400
Message-ID: <4295CF4E.6010006@freenet.de>
Date: Thu, 26 May 2005 15:29:50 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com>	 <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com>	 <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de>	 <20050524133211.GA4896@in.ibm.com>  <42933B7A.3060206@freenet.de> <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=F8391255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

> This way I was able to reduce 129 lines of your code.
>
>This patch is on top of your current set and I haven't even
>tried compiling it. Needs cleanup.
>
>  
>
Going to try it out, looks like a reasonable way to go afaics.

Also, our gcc developer Ulrich Weigand found a way that
might get us rid of the duplication: We can just implement
sync read/write and rely on fallbacks or do simple wrappers
where that doesn't work out well.  Should not show much
penalty since we do sync IO immedieately (memcpy) anyway.
Suparna is right: there needs to be a 3rd way

