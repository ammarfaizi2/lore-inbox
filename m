Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWCNBMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWCNBMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWCNBMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:12:52 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16305 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751707AbWCNBMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:12:51 -0500
Subject: Re: [Patch 1/9] timestamp diff
From: Lee Revell <rlrevell@joe-job.com>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1142298325.5858.40.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142296939.5858.6.camel@elinux04.optonline.net>
	 <1142298072.13256.70.camel@mindpipe>
	 <1142298325.5858.40.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 20:12:43 -0500
Message-Id: <1142298764.13256.73.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 20:05 -0500, Shailabh Nagar wrote:
> On Mon, 2006-03-13 at 20:01, Lee Revell wrote:
> > On Mon, 2006-03-13 at 19:42 -0500, Shailabh Nagar wrote:
> > > +       ret->tv_sec = end->tv_sec - start->tv_sec;
> > > +       ret->tv_nsec = end->tv_nsec - start->tv_nsec; 
> > 
> > What if end->tv_nsec is less than start->tv_nsec?
> 
> The caller of the func can decide what to do. 
> In our usage, we choose to not use the result of such a diff
> but others may want to return an error etc.

You don't think it's a problem that 2.0000001s - 1.9999999s would return
garbage rather than 0.0000002?

Lee

