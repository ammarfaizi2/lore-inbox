Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWJMOXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWJMOXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWJMOXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:23:10 -0400
Received: from kanga.kvack.org ([66.96.29.28]:29904 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750856AbWJMOXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:23:09 -0400
Date: Fri, 13 Oct 2006 10:22:57 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
       linux-kernel@vger.kernel.org, "'linux-aio'" <linux-aio@kvack.org>
Subject: Re: [patch] clarify AIO_EVENTS_OFFSET constant
Message-ID: <20061013142257.GJ4141@kvack.org>
References: <000301c6ee5a$9dfae250$db34030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c6ee5a$9dfae250$db34030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 05:00:24PM -0700, Chen, Kenneth W wrote:
> A clean up patch: I think it is a lot easier to read AIO_EVENTS_OFFSET
> as an offset because of aio_ring at the beginning of a head page, instead
> of doing arithmetic of (event on 2nd page - event on 1st page).

Nak.  Your change fails if aio_ring is not an exact multiple of the 
io_event size due to rounding errors, while the original code rounds 
correctly.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
