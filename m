Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUCJIX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbUCJIXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:23:25 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:55170 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262528AbUCJIXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:23:15 -0500
Date: Wed, 10 Mar 2004 13:54:17 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] call_usermodehelper needs to wait longer
Message-ID: <20040310082416.GA5084@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040309135143.GB26645@in.ibm.com> <20040309133835.2343565c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309133835.2343565c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 01:38:35PM -0800, Andrew Morton wrote:
> I'm not so sure about this.  There are deadlock potentials if the usermode
> application wants to perform some function which requires keventd services
> to complete - the application cannot complete because keventd is itself
> waiting for the application.
> 
> Can we think of any circumstances under which keventd _should_
> synchronously wait for the userspace app?

Honestly I don't know ..Would it be reasonable for somebody
to call request_module from a work function (in which case the above
bug is exposed)? I agree it is not a nice thing if we block keventd
waiting for the app to exit. 

> 
> btw: your patch had whitespace where the tabs should be (email client
> problem), and `patch -p1' format is (much) preferred.

Sorry abt that! The whitespace was because of cut-n-paste ..I have
also downloaded your patch scripts and will start using that for 
generating patches henceforth!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
