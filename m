Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUKPRWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUKPRWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUKPRWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:22:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35488 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262043AbUKPRTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:19:30 -0500
Date: Tue, 16 Nov 2004 17:18:54 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2 dm.c dm_init unresolved reference to _exits
Message-ID: <20041116171854.GB24233@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <27983.1100493381@kao2.melbourne.sgi.com> <20041115112323.GI9939@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115112323.GI9939@apps.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 12:23:23PM +0100, Andries Brouwer wrote:
> On Mon, Nov 15, 2004 at 03:36:21PM +1100, Keith Owens wrote:
> > drivers/md/dm.c dm_int refers to _exits which is defined as __exitdata.
> > With CONFIG_HOTPLUG=n, __exitdata is discarded
> Yes - thanks for reminding - thought of that yesterday night
> but forgot again the next morning.
 
In fact that's the second time someone's introduced a bug like that in
this code: to save someone else from doing it again, please also add 
a comment that the exit functions may be called during init (if an init 
function fails).

Alasdair
-- 
agk@redhat.com
