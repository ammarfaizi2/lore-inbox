Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVBQSTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVBQSTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVBQSTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:19:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261166AbVBQSS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:18:58 -0500
Date: Thu, 17 Feb 2005 13:18:50 -0500
From: Dave Jones <davej@redhat.com>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/cpumem
Message-ID: <20050217181850.GE21623@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Itsuro Oda <oda@valinux.co.jp>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	fastboot <fastboot@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20050203154433.18E4.ODA@valinux.co.jp> <m14qgu81bw.fsf@ebiederm.dsl.xmission.com> <20050216170224.4C66.ODA@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216170224.4C66.ODA@valinux.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 05:49:51PM +0900, Itsuro Oda wrote:
 > Hi, Eric and all
 > 
 > Attached is an implementation of /proc/cpumem.
 > /proc/cpumem shows the valid physical memory ranges.
 > 
 > * i386 and x86_64
 > * implement valid_phys_addr_range() and use it.
 >   (the first argument of the i386 version is little uncomfortable.)
 > * /dev/mem of the i386 version should be mofified. but not yet.
 > 
 > example: amd64 8GB Mem
 > # cat /proc/cpumem
 > 0000000000000000 000000000009b800
 > 0000000000100000 00000000fbe70000
 > 0000000100000000 0000000100000000
 > #
 > start address and size. hex digit.
 > 
 > Any comments, recomendations and suggestions are welcom.

It may make more sense to export the entire e820 (or similar)
bios memory tables. Probably better off in sysfs than adding
more cruft to procfs too.

		Dave

