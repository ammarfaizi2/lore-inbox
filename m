Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVKVXUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVKVXUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKVXUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:20:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4835 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030243AbVKVXUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:20:36 -0500
Message-ID: <4383A790.1090208@us.ibm.com>
Date: Tue, 22 Nov 2005 15:19:44 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "lkml, " <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.14-rt13 / minimum gcc  version
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rt13 makes use of the gcc extension:
	int __builtin_types_compatible_p (type1, type2)
which from what I can tell was first introduced to gcc in version 3.1.1
	http://gcc.gnu.org/onlinedocs/gcc-3.1.1/gcc/Other-Builtins.html

In any case, I am unable to compile rt13 with gcc-2.95.  I have tried various 
-std args as well, but the compiler dies on __builtin_types_compatible_p.

1) Is it acceptable to require >= gcc-3.1.1 to compile a Linux kernel?

2) Would a patch/work-around for gcc-2.95 compatibility be accepted if I provide 
one?  (assuming it is a sane implementation of course :-)

Thanks,


-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
