Return-Path: <linux-kernel-owner+w=401wt.eu-S932141AbXACWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbXACWQm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXACWQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:16:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55228 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141AbXACWQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:16:40 -0500
Date: Wed, 3 Jan 2007 14:15:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-Id: <20070103141556.82db0e81.akpm@osdl.org>
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 13:53:08 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> This patchset implements changes to make filesystem AIO read
> and write asynchronous for the non O_DIRECT case.

Unfortunately the unplugging changes in Jen's block tree have trashed these
patches to a degree that I'm not confident in my repair attempts.  So I'll
drop the fasio patches from -mm.

Zach's observations regarding this code's reliance upon things at *current
sounded pretty serious, so I expect we'd be seeing changes for that anyway?

Plus Jens's unplugging changes add more reliance upon context inside
*current, for the plugging and unplugging operations.  I expect that the
fsaio patches will need to be aware of the protocol which those proposed
changes add.

