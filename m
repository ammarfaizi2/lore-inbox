Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUAHX41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUAHX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:56:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:16064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264371AbUAHX4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:56:21 -0500
Subject: Re: [PATCH linux-2.6.0-test10-mm1] dio-read-race-fix
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Janet Morgan <janetmor@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20031231060956.GB3285@in.ibm.com>
References: <3FCD4B66.8090905@us.ibm.com>
	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	 <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <20031230045334.GA3484@in.ibm.com>
	 <1072830557.712.49.camel@ibm-c.pdx.osdl.net>
	 <20031231060956.GB3285@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1073606144.1831.9.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jan 2004 15:55:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 22:09, Suparna Bhattacharya wrote:

> Since the first filemap_write_and_wait call is redundant and somewhat
> suspect since its called w/o i_sem (I can think of unexpected side effects
> on parallel filemap_write_and_wait calls), have you thought of disabling that
> and then trying to see if you can still recreate the problem ? It may
> not make a difference, but it seems like the right thing to do and could
> at least simplify some of the debugging.
> 
> Regards
> Suparna
> 


Ok, I retried my test without the filemap_write_and_wait() that is not
protected by i_sem and the test still sees uninitialized data.  I'm
still running with test10-mm1 + all the patches I sent out before.
I'm haven't tried 2.6.0-rc*-mm1 yet.  I need to move all my debug code
over to the latest mm kernel.  I also did not want to change too much
at same time.

Daniel



