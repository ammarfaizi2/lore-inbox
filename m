Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVBQPJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVBQPJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVBQPJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:09:44 -0500
Received: from [195.23.16.24] ([195.23.16.24]:32172 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261411AbVBQPEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:04:05 -0500
Message-ID: <4214B255.2090008@grupopie.com>
Date: Thu, 17 Feb 2005 15:03:49 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: govind raj <agovinda04@hotmail.com>
Cc: roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
References: <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl>
In-Reply-To: <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

govind raj wrote:
> Thanks for all the pointers.
> 
> We had taken the /sbin/init from the existing Linux installation from 
> where we had created the customized image. 

Usually distro binaries are dynamically linked (as they should be) so 
you also need to provide the libraries they request.

As a first cut, use bash as your init (so that you have a prompt to test 
stuff). Do a "ldd bash" to check the libraries necessary for this to 
work and create a "/lib" dir on your target system with those. Then copy 
the bash binary to /sbin/init.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
