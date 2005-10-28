Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbVJ1RKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbVJ1RKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbVJ1RKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:10:16 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:41133 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1030558AbVJ1RKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:10:13 -0400
Date: Fri, 28 Oct 2005 10:12:11 -0700
From: thockin@hockin.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vladimir Lazarenko <vlad@lazarenko.net>, linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
Message-ID: <20051028171211.GA29861@hockin.org>
References: <4361408B.60903@lazarenko.net> <m1irvhbqvo.fsf@ebiederm.dsl.xmission.com> <20051028160403.GA26286@hockin.org> <m1acgtbow5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acgtbow5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 10:13:46AM -0600, Eric W. Biederman wrote:
> > If you want to use 4GB in 32 bit mode, you *need* remapping (or you lose
> > part of your memory).  Remapping means you have MORE than 4 GB of physical
> > address, which means you need PAE to use it at all.
> 
> Yes, and PAE works fine with a 32bit kernel.  I agree it is a silly
> configuration and a 64bit kernel would use the memory more
> efficiently.  My basic point was that a dual-core is a recent enough
> processor from AMD that it supports memory remapping.  So with a
> correct BIOS there should be no problems. 

Earlier Opterons had remapping, too, just at the chip-select level.  Even
with remapping, the memory that gets remapped gets mapped above 4 GB, so a
32 bit kernel still needs PAE to address it.
