Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVHSHIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVHSHIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVHSHIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:08:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964886AbVHSHIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:08:24 -0400
Date: Fri, 19 Aug 2005 15:13:44 +0800
From: David Teigland <teigland@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-cluster@redhat.com
Subject: Re: [PATCH 1/3] dlm: use configfs
Message-ID: <20050819071344.GB10864@redhat.com>
References: <20050818060750.GA10133@redhat.com> <20050818212348.GW21228@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818212348.GW21228@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:23:48PM -0700, Mark Fasheh wrote:
> On Thu, Aug 18, 2005 at 02:07:50PM +0800, David Teigland wrote:

> > + * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/nodeid
> > + * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/weight
> > + * /config/dlm/<cluster>/comms/<comm>/nodeid
> > + * /config/dlm/<cluster>/comms/<comm>/local
> > + * /config/dlm/<cluster>/comms/<comm>/addr
>
> So what happened to factoring out the common parts of ocfs2_nodemanager?
> I was quite a big fan of that approach :) Or am I just misunderstanding
> what these patches do?

The nodemanager RFC I sent a month ago
  http://marc.theaimsgroup.com/?l=linux-kernel&m=112166723919347&w=2

amounts to half of dlm/config.c (everything under comms/ above) moved into
a separate kernel module.  That would be trivial to do, and is still an
option to bat around.

I question whether factoring such a small chunk into a separate module is
really worth it, though?  Making all of config.c (all of /config/dlm/
above) into a separate module wouldn't seem quite so strange.  It would
require just a few lines of code to turn it into a stand alone module.

Dave

