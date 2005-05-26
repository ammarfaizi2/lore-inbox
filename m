Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVEZNUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVEZNUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVEZNUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:20:55 -0400
Received: from mout1.freenet.de ([194.97.50.132]:35519 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261324AbVEZNUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:20:49 -0400
Message-ID: <4295CCDF.9070302@freenet.de>
Date: Thu, 26 May 2005 15:19:27 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de> <20050524133211.GA4896@in.ibm.com> <42933B7A.3060206@freenet.de> <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com> <20050526132251.GA5067@in.ibm.com>
In-Reply-To: <20050526132251.GA5067@in.ibm.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=F8391255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

> To get a complete picture, how did you want to handle direct io ?
>
>Regards
>Suparna
>  
>
Just through the regular xip path, O_DIRECT doesn't have any effect
on those files since we do a direct memcpy to disk in the end anyway.
That has the user-visible effect that unalligned reads/writes work with
O_DIRECT.
