Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVAHEAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVAHEAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 23:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVAHEAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 23:00:13 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:36167 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261777AbVAHEAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 23:00:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Nb5iwckrGw40GY5GwZ6VfonZ8sTq7q1cqRd26iUnkZcRPMz2b6hCk80wmZ+ZB/SF2J4JkyhQYOPeciYPqm69jXmZD1SR3zD6vAmFOpAU5DRymZ1jwjL59afideUpj/IiCf/8HuKoqiLpKDfWvZTy7u3nHRlInlh37kIVxMTlaS0=
Message-ID: <9e4733910501072000491d6c04@mail.gmail.com>
Date: Fri, 7 Jan 2005 23:00:09 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: inter_module_get and __symbol_get
Cc: Brian Gerst <bgerst@didntduck.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <20050106225140.GO6184@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106213225.GJ6184@hygelac> <41DDB465.8000705@didntduck.org>
	 <20050106225140.GO6184@hygelac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The inter_module_xxx free DRM is already in Linus BK. Sooner or later
the inter_module_xx exports in the AGP driver should disappear too.

DRM now handles things at compile time. If AGP is enabled at compile
time, AGP support gets built into the DRM module. If AGP is not
enabled, AGP does not get compiled in. If you try to take a DRM that
was built for AGP and move it to a system without, it's not going to
load because it will need the AGP symbols.

-- 
Jon Smirl
jonsmirl@gmail.com
