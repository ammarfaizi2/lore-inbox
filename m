Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWHVR5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWHVR5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHVR5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:57:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:4069 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751426AbWHVR5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:57:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=J5FWuURkUCiYuAiQ29zVq1vRSytRS6u97vygdaBgsUm6adwBibPr+cb2nl6VtW2iRxNX2sxmDYFZ0+Qbz/I9SZ8RUrZiWGzqizs0jcqjh9t4Kmj+kE/9DMJcSd0hjd5S0+dkQzNWY7xm86R58nA7DrikwEnny/HA5Ox2pT1pSDQ=
Message-ID: <44EB4575.6070306@gmail.com>
Date: Tue, 22 Aug 2006 19:57:09 +0200
From: Maciej Rutecki <maciej.rutecki@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.18-rc4-mm2] Compile error in afs
References: <1156209906.17514.8.camel@daplas.org>
In-Reply-To: <1156209906.17514.8.camel@daplas.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas napisał(a):
> With CONFIG_AFS_FSCACHE=n, I get this compile error:
> 
> fs/afs/file.c: In function ‘afs_file_releasepage’:
> fs/afs/file.c:332: error: ‘struct afs_vnode’ has no member named ‘cache’
> make[2]: *** [fs/afs/file.o] Error 1
> make[1]: *** [fs/afs] Error 2
> make: *** [fs] Error 2
> 

Revert fs-cache-make-kafs-use-fs-cache-12.patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/broken-out/fs-cache-make-kafs-use-fs-cache-12.patch

-- 
Maciej Rutecki <maciej.rutecki@gmail.com>
http://www.unixy.pl
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
