Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWARRGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWARRGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWARRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:06:43 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:54677 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751372AbWARRGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:06:42 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Why is wmb() a no-op on x86_64?
References: <1137601417.4757.38.camel@serpentine.pathscale.com>
	<200601181729.36423.ak@suse.de>
	<1137603169.4757.50.camel@serpentine.pathscale.com>
From: Jes Sorensen <jes@sgi.com>
Date: 18 Jan 2006 12:06:39 -0500
In-Reply-To: <1137603169.4757.50.camel@serpentine.pathscale.com>
Message-ID: <yq04q41qxcw.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bryan" == Bryan O'Sullivan <bos@pathscale.com> writes:

Bryan> On Wed, 2006-01-18 at 17:29 +0100, Andi Kleen wrote:
>> Why do you need the barrier?

Bryan> On x86_64, we fiddle with the MTRRs to enable write combining,
Bryan> which makes a huge difference to performance.  It's not clear
Bryan> to me what we should even do on other architectures, since the
Bryan> only generic entry point that even exposes write combining is
Bryan> pci_mmap_page_range, which is for PCI mmap through userspace,
Bryan> and half the arches I've looked at ignore its write_combine
Bryan> parameter.

A job for mmiowb() perhaps?

Cheers,
Jes
