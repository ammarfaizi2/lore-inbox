Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUGFWEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUGFWEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGFWEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:04:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17126 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264499AbUGFWEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:04:45 -0400
Date: Tue, 6 Jul 2004 23:04:28 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, torvalds@osdl.org, agk@redhat.com,
       jim.houston@comcast.net
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-ID: <20040706220428.GN30186@agk.surrey.redhat.com>
Mail-Followup-To: Kevin Corry <kevcorry@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, torvalds@osdl.org, agk@redhat.com,
	jim.houston@comcast.net
References: <200407011035.13283.kevcorry@us.ibm.com> <200407021233.09610.kevcorry@us.ibm.com> <20040702124218.0ad27a85.akpm@osdl.org> <200407061323.27066.kevcorry@us.ibm.com> <20040706142335.14efcfa4.akpm@osdl.org> <20040706213552.GA30237@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706213552.GA30237@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 10:35:52PM +0100, Alasdair G Kergon wrote:
> Yes, but the comments imply that the thing it found might in some
> circumstances not be the thing you asked it to look for 

To clarify, we make two sorts of requests for ids [minor numbers]:
  (a) What is the lowest unused id number?
  (b) Is id number N used or not?

If I interpret things correctly, in case (b) if N is larger than the
the highest id number currently stored it might still return non-NULL 
(if lower order bits match lower order bits of a different stored id).

[Would it be sufficient for the caller to keep track of the highest 
allocated ID and check before calling, or is the masking sometimes
stronger than that?]

Alasdair
-- 
agk@redhat.com
