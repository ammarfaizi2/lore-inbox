Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVDFFSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVDFFSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVDFFSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:18:10 -0400
Received: from CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com ([69.194.86.29]:20611
	"EHLO kenichi") by vger.kernel.org with ESMTP id S262095AbVDFFSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:18:06 -0400
From: Andrew James Wade 
	<ajwade@CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com>
To: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.12-rc2-mm1 compile error in mmx.c
Date: Wed, 6 Apr 2005 01:17:13 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <425339E3.8030404@gmail.com>
In-Reply-To: <425339E3.8030404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504060117.14188.ajwade@CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 5, 2005 09:22 pm, Berck E. Nash wrote:
> 2.6.12-rc2-mm1 fails to build for me with the following error:
> 
> arch/i386/lib/mmx.c:374: error: conflicting types for `mmx_clear_page'
> include/asm/mmx.h:11: error: previous declaration of `mmx_clear_page'
> make[1]: *** [arch/i386/lib/mmx.o] Error 1
> make: *** [arch/i386/lib] Error 2

I don't know the proper fix, but reversing this patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/broken-out/add-a-clear_pages-function-to-clear-pages-of-higher.patch
worked for me.
