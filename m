Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVD2ViU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVD2ViU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVD2Vh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:37:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:56240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263017AbVD2VfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:35:08 -0400
Date: Fri, 29 Apr 2005 14:34:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: pbadari@us.ibm.com, suparna@in.ibm.com, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-Id: <20050429143427.19b3990d.akpm@osdl.org>
In-Reply-To: <1114809139.10473.70.camel@localhost.localdomain>
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113244710.4413.38.camel@localhost.localdomain>
	<1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113288087.4319.49.camel@localhost.localdomain>
	<1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	<1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	<1114207837.7339.50.camel@localhost.localdomain>
	<1114659912.16933.5.camel@mindpipe>
	<1114715665.18996.29.camel@localhost.localdomain>
	<20050429135211.GA4539@in.ibm.com>
	<1114794608.10473.18.camel@localhost.localdomain>
	<1114803764.10473.46.camel@localhost.localdomain>
	<20050429135705.3f4831bd.akpm@osdl.org>
	<1114809139.10473.70.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
>  right now direct io write to a hole is actually handled by buffered IO.
>  If so, there must be some valid reason that I could not see now.

Oh yes, that's right.  It's all to do with the fixes which went in a year
ago to prevent concurrent readers from peeking at uninitialised disk
blocks.

