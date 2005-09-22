Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVIVIkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVIVIkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVIVIkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:40:51 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:63563 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1751453AbVIVIkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:40:51 -0400
Date: Thu, 22 Sep 2005 01:40:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Karthik Sarangan <karthiks@cdac.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT for block device
Message-ID: <20050922084036.GI27375@ca-server1.us.oracle.com>
Mail-Followup-To: Karthik Sarangan <karthiks@cdac.in>,
	linux-kernel@vger.kernel.org
References: <4332697C.7070409@cdac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332697C.7070409@cdac.in>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 01:51:16PM +0530, Karthik Sarangan wrote:
> open("/dev/sdb", O_DIRECT) succeeds.
> A 'read' or 'write' returns -1 and errno is EINVAL.

	You must align your buffer to at least sector size.  See
posix_memalign(3).

-- 

Life's Little Instruction Book #30

	"Never buy a house without a fireplace."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
