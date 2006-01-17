Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWAQPDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWAQPDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWAQPDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:03:01 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:38663 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751157AbWAQPC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:02:59 -0500
X-ME-UUID: 20060117150257806.C4CA01C01644@mwinf0507.wanadoo.fr
Date: Tue, 17 Jan 2006 16:06:45 +0100
From: Philippe Elie <phil.el@wanadoo.fr>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, levon@movementarian.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: make "struct d_cookie" dependable on CONFIG_PROFILING?
Message-ID: <20060117150645.GA775@zaniah>
References: <20060117122701.GA26491@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117122701.GA26491@dmt.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006 at 10:27 +0000, Marcelo Tosatti wrote:


> Is there any good reason for not making "struct dcookie_struct
> *d_cookie" dependable on CONFIG_PROFILING? 
> 
> Shrinks "struct dentry" from 128 bytes to 124 on x86, allowing
> 31 objects per slab instead of 30.
> 
> John Levon informed me that he had such selection in his
> original patches, but was asked but take it off (?).

iirc this was seen usefull by other tools than profiler but 
fs/Makefile contains:

obj-$(CONFIG_PROFILING)		+= dcookies.o

and nobody complained agaisnt it.

-- 
regards,
Philippe Elie

