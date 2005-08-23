Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVHWClk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVHWClk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 22:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVHWClk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 22:41:40 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:35238 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751328AbVHWClj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 22:41:39 -0400
Date: Mon, 22 Aug 2005 19:41:16 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-cluster@redhat.com
Subject: Re: [PATCH 1/3] dlm: use configfs
Message-ID: <20050823024116.GY21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050818060750.GA10133@redhat.com> <20050818212348.GW21228@ca-server1.us.oracle.com> <20050819071344.GB10864@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819071344.GB10864@redhat.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 03:13:44PM +0800, David Teigland wrote:
> The nodemanager RFC I sent a month ago
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=112166723919347&w=2
> 
> amounts to half of dlm/config.c (everything under comms/ above) moved into
> a separate kernel module.  That would be trivial to do, and is still an
> option to bat around.
Yeah ok, so the address/id/local part is still there. As is much of the API
to query those attributes.

> I question whether factoring such a small chunk into a separate module is
> really worth it, though?
IMHO, yes. Mostly because we both have very similar basic requirements there
and it seems a waste to have duplicated code (even if it's not a huge
amount). Future projects wanting to query basic node information from the
kernel could have simply used that API without having to further duplicate
code too. That said, I'm not sure it has to be done *now*

Was there anything in my comments which made going forward with that
approach difficult for dlm?

> Making all of config.c (all of /config/dlm/ above) into a separate module
> wouldn't seem quite so strange. It would require just a few lines of code
> to turn it into a stand alone module.
Without the dlm specifics, right? It's perfectly fine with me if dlm has a
couple more attributes that it wants on a node object - OCFS2 simply won't
query them.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
