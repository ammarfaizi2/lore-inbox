Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWFUEbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWFUEbA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbWFUEbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:31:00 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5060 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750870AbWFUEa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:30:59 -0400
Message-ID: <4498CB6F.9000003@zytor.com>
Date: Tue, 20 Jun 2006 21:30:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Kyle McMartin <kyle@parisc-linux.org>, jeremy@goop.org,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk,
       chrisw@sous-sol.org
Subject: Re: [PATCH] Implement kasprintf
References: <44988B5C.9080400@goop.org>	<20060621030444.GG20625@skunkworks.cabal.ca> <20060620202617.f39d7ca6.akpm@osdl.org>
In-Reply-To: <20060620202617.f39d7ca6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 20 Jun 2006 23:04:44 -0400
> Kyle McMartin <kyle@parisc-linux.org> wrote:
> 
>> On Tue, Jun 20, 2006 at 04:57:16PM -0700, Jeremy Fitzhardinge wrote:
>>> +char *kasprintf(gfp_t gfp, const char *fmt, ...)
>>> +{
>> Why not just asprintf? We don't have ksprintf... 
> asprintf() doesn't take a gfp_t arg.
> 

Or, more generally: if we change the API, change the name.  kmalloc() is 
different from malloc() as it is invoked differently, as is kasprintf().

printk() was arguably a mistake, although it's semi-justified a posteori 
since it takes the priority pseudo-argument now.

	-hpa
