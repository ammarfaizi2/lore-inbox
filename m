Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTAQAwf>; Thu, 16 Jan 2003 19:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTAQAwf>; Thu, 16 Jan 2003 19:52:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:33497 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267346AbTAQAwe>; Thu, 16 Jan 2003 19:52:34 -0500
Subject: Re: Fwd: [PATCH] hangcheck-timer
From: john stultz <johnstul@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200301170059.h0H0x0a25262@eng2.beaverton.ibm.com>
References: <200301170059.h0H0x0a25262@eng2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042764919.29941.2.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 Jan 2003 16:55:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Attached is a patch adding hangcheck-timer.  It is used to detect
>  when the system goes out to lunch for a period of time, and then
>  returns.  This is interesting for debugging drivers as well as for
>  clustering environments.
>         The module sets a timer.  When the timer goes off, it then uses
>  get_cycles() to determine how much real time has passed.

This won't work on systems which do not have synchronized TSCs. Might
you consider using do_gettimeofday() instead? 

thanks
-john


