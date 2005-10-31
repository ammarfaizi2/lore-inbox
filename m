Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVJaCmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVJaCmb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVJaCmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:42:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751281AbVJaCma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:42:30 -0500
Date: Sun, 30 Oct 2005 21:42:17 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
Message-ID: <20051031024217.GA25709@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200510290000.j9T00Bqd001135@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510290000.j9T00Bqd001135@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 05:00:11PM -0700, Linux Kernel wrote:
 > tree 68609a74c3bc43e510f58f9c808a0a74e9d23452
 > parent 4153812fc10ea91cb1a7b6ea4f4337dd211c1ef7
 > author Grant Coady <gcoady@gmail.com> Thu, 29 Sep 2005 11:06:40 +1000
 > committer Greg Kroah-Hartman <gregkh@suse.de> Sat, 29 Oct 2005 05:36:59 -0700
 > 
 > [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
 > 
 > pci_ids.h cleanup: removed non-referenced symbols, compile tested
 > with 'make allmodconfig'
 > 
 > Signed-off-by: Grant Coady <gcoady@gmail.com>
 > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

This patch is removing some PCI idents from drivers that are currently
marked BROKEN on some/all architectures.  It seems counterproductive
to create even more work to get those drivers fixed.

Especially in the case of for eg, the advansys scsi driver, which
actually works for some people, even though it isn't updated to use
modern scsi layer interfaces.

		Dave

