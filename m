Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWGFSWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWGFSWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWGFSWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:22:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750708AbWGFSWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:22:05 -0400
Date: Thu, 6 Jul 2006 14:20:41 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060706182041.GF13168@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, kai@germaschewski.name,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <20060706163728.GN26941@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706163728.GN26941@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 06:37:28PM +0200, Adrian Bunk wrote:
 > Currently, using an undeclared function gives a compile warning, but it 
 > can lead to a nasty to debug runtime stack corruptions if the prototype 
 > of the function is different from what gcc guessed.
 > 
 > With -Werror-implicit-function-declaration we are getting an immediate
 > compile error instead.
 > 
 > Signed-off-by: Adrian Bunk <bunk@stusta.de>

I've been carrying pretty much the same patch in Fedora for months,
and making sure it still builds across x86/x86-64/s390/ia64/ppc32/ppc64.
It saves a lot of time when you're building a large heavily modular kernel.
(like that from a distro config say)

Signed-off-by: Dave Jones <davej@redhat.com>

-- 
http://www.codemonkey.org.uk
