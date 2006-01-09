Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWAII1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWAII1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 03:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWAII1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 03:27:44 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:4747 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750879AbWAII1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 03:27:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=phdJf2xjQ/sAUdrQZq+CnS8YpbtpuZvQWprdjhEVUGCTitOGb3cFVHLBM+aJzUr3K+vj/mP8/ETbs+lbjTDEsnZg96EI/ZNXUlBJ36GT2D72GpNQjhkCJ14m6Cuju0gSJ5gQNMDi5hPInIPiBaI6Xa6kiEt/FKQ7ZIcGRXmxBFg=
Message-ID: <43C21E9D.3070106@gmail.com>
Date: Mon, 09 Jan 2006 13:28:13 +0500
From: "Alexander E. Patrakov" <patrakov@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] It's UTF-8
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
In-Reply-To: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>  	if (!strcmp(opts->iocharset, "utf8")) {
>  		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
>  		       " for FAT filesystems, filesystem will be case sensitive!\n");

This warning better reads in such a way:

FAT: this is not the recommended filesystem for use with UTF-8 filenames.

Reason: the utf8 IO charset is the only IO charset that displays 
filenames properly in UTF-8 locales. So the choice is really between 
case-sensitive filenames (iocharset=utf8) and completely unreadable 
filenames (everything else).

-- 
Alexander E. Patrakov
