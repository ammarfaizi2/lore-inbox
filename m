Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVGOKPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVGOKPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVGOKPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:15:32 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:42026 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261765AbVGOKP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:15:26 -0400
Message-ID: <42D78D01.8040809@tu-harburg.de>
Date: Fri, 15 Jul 2005 12:16:33 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <20050714201120.73570316.akpm@osdl.org>
In-Reply-To: <20050714201120.73570316.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 >
 > Does it really matter?
 >

Yes! At least for me and my union mounts implementation.

 >
 > I wonder if these should be in libfs - sysfs has the same problem, for
 > example and someone might want to come along and fix that up too.

Ok, I will check that next week. But AFAIK, sysfs does not use the libfs 
calls to modify directory contents. Therefore fixing the i_size problem 
must be done inside the sysfs code. For hugetblfs etc. it would be 
better to fix it in libfs.

Jan
