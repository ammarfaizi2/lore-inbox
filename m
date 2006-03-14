Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWCNBF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWCNBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWCNBF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:05:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24515 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932531AbWCNBF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:05:27 -0500
Subject: Re: [Patch 1/9] timestamp diff
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1142298072.13256.70.camel@mindpipe>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142296939.5858.6.camel@elinux04.optonline.net>
	 <1142298072.13256.70.camel@mindpipe>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142298325.5858.40.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 20:05:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 20:01, Lee Revell wrote:
> On Mon, 2006-03-13 at 19:42 -0500, Shailabh Nagar wrote:
> > +       ret->tv_sec = end->tv_sec - start->tv_sec;
> > +       ret->tv_nsec = end->tv_nsec - start->tv_nsec; 
> 
> What if end->tv_nsec is less than start->tv_nsec?

The caller of the func can decide what to do. 
In our usage, we choose to not use the result of such a diff
but others may want to return an error etc.

--Shailabh
  
> 
> Lee
> 

