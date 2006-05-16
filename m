Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWEPSZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWEPSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWEPSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:25:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932494AbWEPSZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:25:56 -0400
Date: Tue, 16 May 2006 11:28:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation
 prerequisite
Message-Id: <20060516112824.39b49563.akpm@osdl.org>
In-Reply-To: <446A1023.6020108@de.ibm.com>
References: <446A1023.6020108@de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> wrote:
>
> need sched_clock for latency statistics

sched_clock() probably isn't suitable for this application.  It's a
scheduler thing and has a number of accuracy problems.

But I thought we discussed this last time around?  Maybe not.

Maybe you've considered sched_clock()'s drawbacks and you've decided
they're all acceptable.  If so, the changelog should have described the
reasoning.

But even if so, sched_clock() isn't something we want to be exporting to
modules.

