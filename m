Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbVFYHqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbVFYHqu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 03:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbVFYHqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 03:46:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50618 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263364AbVFYHqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 03:46:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm patch] i386: enable REGPARM by default
Date: Sat, 25 Jun 2005 10:46:22 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20050624200916.GJ6656@stusta.de>
In-Reply-To: <20050624200916.GJ6656@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251046.22944.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 23:09, Adrian Bunk wrote:
> This patch should _not_ go into Linus' tree.
> 
> At some time in the future, we want to unconditionally enable REGPARM on 
> i386.
> 
> Let's give it a bit broader testing coverage among -mm users.
> 
> This patch:
> - removes the dependency of REGPARM on EXPERIMENTAL
> - let REGPARM default to y
> 
> This patch assumes that people who use -mm are willing to test some more 
> experimental features.
> 
> After this patch, REGPARM is still a config option users can disable.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Jens Axboe had hit an obscure bug with regparm just yesterday.
It happened for him with gcc 3.3.5.

I have a preprocessed .c file which allows to reporduce this.
For me, gcc 3.3.6 is okay. need to build 3.3.5 and test.

Meanwhile, maybe we shall prohibit regparm if gcc <=3.3.6 or 3.4?
--
vda

