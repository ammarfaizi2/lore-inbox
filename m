Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275344AbTHGO1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275345AbTHGO1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:27:10 -0400
Received: from verein.lst.de ([212.34.189.10]:26839 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S275344AbTHGO1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:27:07 -0400
Date: Thu, 7 Aug 2003 16:26:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <20030807142624.GA29208@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mitch@0Bits.COM,
	Erik Andersen <andersen@codepoet.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.5 () IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I dont understand how the vmap change can break DRM. 
> 
> The vmap patch only changes internal mm/vmalloc.c code (vmalloc() call
> acts exactly the same way as before AFAICS).
> 
> Anyway, Mitch (or Erik who's seeing the problem), can please revert the
> vmap() change to check if its causing the mentioned problem? 

vmap() doesn't break DRM.  The external drm code just detects that
vmap is present and then uses the new interface, but this new code
also expects a new exported symbol.

The DRM code in your tree is completly unaffected.

