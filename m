Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965346AbWJ3REM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbWJ3REM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWJ3REM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:04:12 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47257 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965347AbWJ3REK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:04:10 -0500
Date: Mon, 30 Oct 2006 22:39:16 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061030170916.GA9588@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <20061030024320.962b4a88.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030024320.962b4a88.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 02:43:20AM -0800, Paul Jackson wrote:
> > Consensus:
> > 	...
> > 	- Dont support heirarchy for now
> 
> Looks like this item can be dropped from the concensus ... ;).
> 
> I for one would recommend getting the hierarchy right from the
> beginning.
> 
> Though I can appreciate that others were trying to "keep it simple"
> and postpone dealing with such complications.  I don't agree.
> 
> Such stuff as this deeply affects all that sits on it.  Get the
> basic data shape presented by the kernel-user API right up front.
> The rest will follow, much easier.

Hierarchy has implications in not just the kernel-user API, but also on
the controller design. I would prefer to progressively enhance the
controller, not supporting hierarchy in the begining.

However you do have a valid concern that, if we dont design the user-kernel 
API keeping hierarchy in mind, then we may break this interface when we 
latter add hierarchy support, which will be bad. 

One possibility is to design the user-kernel interface that supports hierarchy
but not support creating hierarchical depths more than 1 in the initial 
versions. Would that work?

-- 
Regards,
vatsa
