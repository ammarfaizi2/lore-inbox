Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVCVCmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVCVCmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVCVClz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:41:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8102 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262215AbVCVB4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:56:04 -0500
Date: Mon, 21 Mar 2005 20:56:03 -0500
From: Dave Jones <davej@redhat.com>
To: Dan Maas <dmaas@maasdigital.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Distinguish real vs. virtual CPUs?
Message-ID: <20050322015603.GB19541@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dan Maas <dmaas@maasdigital.com>, linux-kernel@vger.kernel.org
References: <20050321202726.A7630@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321202726.A7630@morpheus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 08:27:26PM -0500, Dan Maas wrote:
 > Is there a canonical way for user-space software to determine how many
 > real CPUs are present in a system (as opposed to HyperThreaded or
 > otherwise virtual CPUs)?
 > 
 > We have an application that for performance reasons wants to run one
 > process per CPU. However, on a HyperThreaded system /proc/cpuinfo
 > lists two CPUs, and running two processes in this case is the wrong
 > thing to do. (Hyperthreading ends up degrading our performance,
 > perhaps due to cache or bus contention).

Compare the 'physical id' fields of /proc/cpuinfo, and count
how many unique values you get.
Ie, on my dual+ht, I see..

physical id     : 0
physical id     : 0
physical id     : 3
physical id     : 3

Which indicates 2 real CPUs split in two.

		Dave

