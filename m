Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUG1UfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUG1UfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUG1UfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:35:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:52903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263585AbUG1UfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:35:07 -0400
Date: Wed, 28 Jul 2004 13:33:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: mbligh@aracnet.com, jbarnes@engr.sgi.com, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@osdl.org, hari@in.ibm.com
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040728133337.06eb0fca.akpm@osdl.org>
In-Reply-To: <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> "Martin J. Bligh" <mbligh@aracnet.com> writes:
> > We discussed this at kernel summit a bit - it'd be safer to make the devices
> > clear down on boot up, rather than shutdown, if possible ... less work to
> > do on the unstable base.
> 
> Agreed, but I think for starters we should capture the low hanging fruit
> by calling the shutdown method and then increasingly harden the
> code by performing less in the kernel that panics and more in the
> cleanup kernel.

We really don't want to be calling driver shutdown functions from a crashed
kernel.

