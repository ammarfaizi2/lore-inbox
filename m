Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWBSVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWBSVVi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWBSVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:21:38 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:22181 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S932249AbWBSVVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:21:37 -0500
Date: Sun, 19 Feb 2006 16:21:22 -0500
From: Dave Jones <davej@redhat.com>
To: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
Message-ID: <20060219212122.GA7974@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
	Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219210733.GA3682@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219210733.GA3682@linux-sh.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 11:07:33PM +0200, Paul Mundt wrote:
 > This is a small patch set for getting rid of relayfs, and moving the core of
 > its functionality to kernel/relay.c. The API is kept consistent for everything
 > but the relayfs-specific bits, meaning people will have to use other file
 > systems to implement relay channel buffers.

What about the userspace visible API for things already using relayfs,
like systemtap ?  Whilst technically these patches may make sense,
yanking the rug underneath applications as soon as they've started
using it without warning or a migration period doesn't sound too good an idea.

It's taken us *years* to try and get rid of devfs, why should relayfs
get ripped out any quicker, when it has valid users?

		Dave

