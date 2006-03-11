Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752294AbWCKB5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbWCKB5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbWCKB5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:57:33 -0500
Received: from quechua.inka.de ([193.197.184.2]:28335 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1752064AbWCKB5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:57:33 -0500
Date: Sat, 11 Mar 2006 02:57:31 +0100
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance
Message-ID: <20060311015731.GA16912@lina.inka.de>
References: <20060310002121.GJ27280@ca-server1.us.oracle.com> <E1FHWCm-0002rT-00@calista.inka.de> <20060311010913.GN27280@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311010913.GN27280@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 05:09:13PM -0800, Mark Fasheh wrote:
> until the locks needs to be upgraded or downgraded. This provides a very
> large performance increase over always asking the DLM for a new lock.

Yes, it is basically the same problem as the buffer cache. Excessive
single-use patterns dirty the small cache or require a too big cache to be
usefull.

Maybe a user specific limit of percentage of hash (and locks) used? I mean
the untar test case is a bit synthetic, but think of concurrent read access
in a cluster of nntp servers (news article pool).

Gruss
Bernd
