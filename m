Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUAIDtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUAIDtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:49:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:2510 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265564AbUAIDtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:49:45 -0500
Date: Fri, 9 Jan 2004 09:25:10 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Janet Morgan <janetmor@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH linux-2.6.0-test10-mm1] dio-read-race-fix
Message-ID: <20040109035510.GA3279@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3FCD4B66.8090905@us.ibm.com> <1070674185.1929.9.camel@ibm-c.pdx.osdl.net> <1070907814.707.2.camel@ibm-c.pdx.osdl.net> <1071190292.1937.13.camel@ibm-c.pdx.osdl.net> <20031230045334.GA3484@in.ibm.com> <1072830557.712.49.camel@ibm-c.pdx.osdl.net> <20031231060956.GB3285@in.ibm.com> <1073606144.1831.9.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073606144.1831.9.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 03:55:44PM -0800, Daniel McNeil wrote:
> On Tue, 2003-12-30 at 22:09, Suparna Bhattacharya wrote:
> 
> > Since the first filemap_write_and_wait call is redundant and somewhat
> > suspect since its called w/o i_sem (I can think of unexpected side effects
> > on parallel filemap_write_and_wait calls), have you thought of disabling that
> > and then trying to see if you can still recreate the problem ? It may
> > not make a difference, but it seems like the right thing to do and could
> > at least simplify some of the debugging.
> > 
> > Regards
> > Suparna
> > 
> 
> 
> Ok, I retried my test without the filemap_write_and_wait() that is not
> protected by i_sem and the test still sees uninitialized data.  I'm
> still running with test10-mm1 + all the patches I sent out before.
> I'm haven't tried 2.6.0-rc*-mm1 yet.  I need to move all my debug code
> over to the latest mm kernel.  I also did not want to change too much
> at same time.

Did you have a chance to try akpm's patch for filemap_fdatawait ? 
(you should be able to apply it to the same kernel that you are running
with, I think)

Regards
Suparna

> 
> Daniel
> 
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

