Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTDWPVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTDWPVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:21:35 -0400
Received: from havoc.daloft.com ([64.213.145.173]:166 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264085AbTDWPVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:21:34 -0400
Date: Wed, 23 Apr 2003 11:33:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Stephane Ouellette <ouellettes@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Undefined symbol sync_dquots_dev() in quota.c
Message-ID: <20030423153341.GA5561@gtf.org>
References: <3EA6B13A.4000408@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6B13A.4000408@videotron.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:28:58AM -0400, Stephane Ouellette wrote:
> Folks,
> 
>   the following patch fixes a compile error under 2.4.21-rc1-ac1. 
> sync_dev_dquots() is undefined if CONFIG_QUOTA is not set.

The right fix would be to make sure a no-op version of sync_dev_dquots
exists for that case.

	Jeff



