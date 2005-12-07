Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbVLGXGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbVLGXGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVLGXGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:06:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60867 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030434AbVLGXGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:06:44 -0500
Message-ID: <43976AFD.7020707@watson.ibm.com>
Date: Wed, 07 Dec 2005 23:06:37 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>,
       Suparna Bhattacharya <bsuparna@in.ibm.com>
Subject: Re: [ckrm-tech] [RFC][Patch 3/5] Per-task delay accounting: Sync
   block I/O delays
References: <43975D45.3080801@watson.ibm.com>	 <439760CE.7050401@watson.ibm.com> <1133994835.30387.49.camel@localhost>
In-Reply-To: <1133994835.30387.49.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2005-12-07 at 22:23 +0000, Shailabh Nagar wrote:
> 
>>+       if (-EIOCBQUEUED == ret) {
>>+               __attribute__((unused)) struct timespec start, end;
>>+
> 
> 
> Those "unused" things suck.  They're really ugly.
> 
> Doesn't making your delay functions into static inlines make the unused
> warnings go away?

They do indeed. Thanks !
It was a holdover from when the delay funcs were macros. Will fix everywhere.

--Shailabh


> 
> -- Dave
