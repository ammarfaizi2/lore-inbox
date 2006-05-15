Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWEOQvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWEOQvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWEOQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:51:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:14359 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964849AbWEOQvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:51:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jY8brxmZ2CEDAK7fywVW4YEzDlWgOa16j5zs8tibAqlQ87BH4Z/UdPh2y3ZpDBiYT5W6qeFuQzcpuOy9bQ9STERd5W4CM3RRUiKtA8Cj3qBGQb2jY7/EydQKWniA5tfawYWORZt7F7SCX83uO5mEQGsnLuweG1COTIPjr3Zvs/M=
Date: Mon, 15 May 2006 20:49:38 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: 2.6.17-rc4-mm1
Message-ID: <20060515164938.GB10143@mipter.zuzino.mipt.ru>
References: <20060515005637.00b54560.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   - Added the ecryptfs filesystem

  CC [M]  fs/ecryptfs/super.o
fs/ecryptfs/super.c: In function `ecryptfs_statfs':
fs/ecryptfs/super.c:129: warning: passing arg 1 of `vfs_statfs' from incompatible pointer type
fs/ecryptfs/super.c: At top level:
fs/ecryptfs/super.c:207: warning: initialization from incompatible pointer type

* ->statfs wants vfsmount as first argument
* ecryptfs_statfs() is inlined

