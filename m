Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVGLQDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVGLQDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGLQBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:01:49 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:9981 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261504AbVGLQA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:00:59 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jason Baron <jbaron@redhat.com>
In-Reply-To: <17107.57641.217499.429075@tut.ibm.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
	 <17107.57641.217499.429075@tut.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 12:00:46 -0400
Message-Id: <1121184046.6917.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 10:26 -0500, Tom Zanussi wrote:

> I don't really know how we would get around using vmap - it seems like
> the alternatives, such as managing an array of pages or something like
> that, would slow down the logging path too much to make it useful as a
> low overhead logging mechanism.  I you have any ideas though, please
> let me know.

Tom,

My logdev device was pretty quick! The managing of the pages were
negligible to the copying of the data to the buffer. Although, sometimes
you needed to copy across buffers, but this too wouldn't be too much of
an impact.

-- Steve


