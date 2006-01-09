Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWAILiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWAILiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWAILiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:38:16 -0500
Received: from khc.piap.pl ([195.187.100.11]:11018 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751030AbWAILiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:38:15 -0500
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] It's UTF-8
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
	<43C21E9D.3070106@gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 09 Jan 2006 12:38:07 +0100
In-Reply-To: <43C21E9D.3070106@gmail.com> (Alexander E. Patrakov's message of "Mon, 09 Jan 2006 13:28:13 +0500")
Message-ID: <m3ek3hhbs0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander E. Patrakov" <patrakov@gmail.com> writes:

> Alexey Dobriyan wrote:
>
>>  	if (!strcmp(opts->iocharset, "utf8")) {
>>  		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
>>  		       " for FAT filesystems, filesystem will be case sensitive!\n");
>
> This warning better reads in such a way:
>
> FAT: this is not the recommended filesystem for use with UTF-8 filenames.
>
> Reason: the utf8 IO charset is the only IO charset that displays
> filenames properly in UTF-8 locales. So the choice is really between
> case-sensitive filenames (iocharset=utf8) and completely unreadable
> filenames (everything else).

And UTF-8 locale seems to be the only really sane today. I'd kill the
whole warning.
-- 
Krzysztof Halasa
