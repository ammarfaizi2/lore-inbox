Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUFVXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUFVXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUFVXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:40:58 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:33011 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S264924AbUFVXkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:40:49 -0400
Message-ID: <40D8C378.5030202@ThinRope.net>
Date: Wed, 23 Jun 2004 08:40:40 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does parallel make work for modules?
References: <20040622220813.GA306@lucon.org>
In-Reply-To: <20040622220813.GA306@lucon.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:
> When building 2.6.7 on a 4way Linux/ia64, "make -j4 modules" doesn't
> spawn 4 jobs. I got
> 
>  5756 pts/0    S      0:00 make -s -j4 modules
>  5868 pts/0    S      0:00 make -f scripts/Makefile.build obj=fs
>  7240 pts/0    S      0:00 make -f scripts/Makefile.build obj=fs/nfs
>  7269 pts/0    S      0:00 /bin/sh -c set -e; ?   gcc -Wp,-MD,fs/nfs/.pagelist.o. 
>  7270 pts/0    S      0:00 gcc -Wp,-MD,fs/nfs/.pagelist.o.d -nostdinc -iwithprefi
>  7271 pts/0    S      0:00 /usr/gcc-3.4/libexec/gcc/ia64-unknown-linux-gnu/3.4.1/
>  7272 pts/0    R      0:00 as -x -o fs/nfs/pagelist.o -
> 
> 2.4 kernel module build work fine. Any ideas?

-j8 (and distcc) WFM since 2.6.0 without problems. All CPUs (4+) are at almost 100% during the build.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
