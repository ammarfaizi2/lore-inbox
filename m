Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVKAWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVKAWid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVKAWid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:38:33 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:56785 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751373AbVKAWic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:38:32 -0500
Message-ID: <044801c5df35$c6ffc9c0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Paul Jackson" <pj@sgi.com>
Cc: <linux-kernel@vger.kernel.org>, "Bill Davidsen" <davidsen@tmr.com>
References: <035101c5df17$223eccb0$0400a8c0@dcccs><20051101123648.5743a5cf.pj@sgi.com><03c501c5df2c$9a19e2f0$0400a8c0@dcccs> <20051101142403.4b0897c9.pj@sgi.com>
Subject: Re: cpuset - question
Date: Tue, 1 Nov 2005 23:44:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Paul Jackson, Bill Davidsen!

Yes, with echo 0 > mems, this is works fine! :-)

But the documentation is a little small for cpusets...

Thanks

Janos
----- Original Message ----- 
From: "Paul Jackson" <pj@sgi.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 01, 2005 11:24 PM
Subject: Re: cpuset - question


> > In this config i need NUMA option enabled to use cpusets?
>
> No - if you got this far, cpusets are working for you.
>
> You would need NUMA if you had multiple memory nodes.
>
> I'm guessing you have one collection of RAM modules,
> all equally distant from the processors, which is not
> a NUMA (Non-Uniform-Memory-Architecture) system.
>
> I only mentioned NUMA because if you did have NUMA
> hardware, then you would need to CONFIG it into to
> your kernel to make full use of your multiple memory
> nodes.  I doubt that applies to you.
>
> It looks like you have multiple (4 logical with HT)
> CPUs, numbered 0, 1, 2, and 3, and one Memory Node,
> numbered 0.
>
> Cpusets should work for you - just "echo 0", not "echo 1"
> into the "mems" files.  Your one and only Memory Node
> is numbered "0", not "1".
>
> Actually, make that "/bin/echo", not "echo", so you can
> see the error messages.
>
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

