Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWHYUMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWHYUMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWHYUMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:12:22 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37310
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750910AbWHYUMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:12:21 -0400
From: Rob Landley <rob@landley.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
Date: Fri, 25 Aug 2006 16:11:50 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433068.3012.115.camel@pmac.infradead.org>
In-Reply-To: <1156433068.3012.115.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251611.50616.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 August 2006 11:24 am, David Woodhouse wrote:
> Using a combination of these two compiler options for building kernel
> code leads to some useful optimisation

BusyBox has been doing this for months now: "build at once" is one of our 
config options.  I'd like to point out that gcc eats needs several hundred 
megabytes of ram to do this and you have no useful progress indicator between 
starting and ending.  But the result is definitely smaller.

We also tell the linker "--sort-common --gc-sections" which may or may not 
apply here...

Rob
-- 
Never bet against the cheap plastic solution.
