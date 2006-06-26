Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWFZPEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWFZPEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWFZPEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:04:34 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:33342 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932447AbWFZPEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:04:32 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=gIGhqrK6q1/HL0QT2A3bSHVibO1pa+B+A/nCL3ECZKafPazhNr5xgEGI/204AWj5fe1ZztaBeGwU2nAG5qdh3Z6PgTz9K9Qz7X04OTEmvN2zv3/cx6oJqQO+4q674f+u;
X-IronPort-AV: i="4.06,176,1149483600"; 
   d="scan'208"; a="35482340:sNHT56961828"
Date: Mon, 26 Jun 2006 10:04:35 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: minyard@acm.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       peter@palfrader.org, openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] [PATCH] IPMI: use schedule in kthread
Message-ID: <20060626150434.GA14109@lists.us.dell.com>
References: <20060626140819.GA17804@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626140819.GA17804@localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 09:08:19AM -0500, @ wrote:
> The kthread used to speed up polling for IPMI was using udelay
> when the lower-level state machine told it to do a short delay.
> This just used CPU and didn't help scheduling, thus causing bad
> problems with other tasks.  Call schedule() instead.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>

Acked-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
