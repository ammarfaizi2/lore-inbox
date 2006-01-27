Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWA0DYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWA0DYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWA0DYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:24:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030275AbWA0DYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:24:19 -0500
Date: Thu, 26 Jan 2006 19:23:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: dada1@cosmosbay.com, penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
Message-Id: <20060126192342.7341f9b2.akpm@osdl.org>
In-Reply-To: <43D96758.4030808@shadowen.org>
References: <20060124232406.50abccd1.akpm@osdl.org>
	<43D785E1.4020708@shadowen.org>
	<84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>
	<43D7AB49.2010709@shadowen.org>
	<1138212981.8595.6.camel@localhost>
	<43D7E83D.7040603@shadowen.org>
	<84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>
	<43D96758.4030808@shadowen.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> Yes.  I think I have this one.  It appears that the patch below is the
>  trigger for all our recent panic woe's.  The last of the testing should
>  complete in the next few hours and I will be able to confirm that
>  hypothesis; results so far are all good.
> 
>  	reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch

That patch did have some missed conversions, which might well explain the
crash.

Thanks for narrowing it down - I'll keep that patch in next -mm (and will
include the known fixups).  Could you please boot test that?  If we're
still in trouble, I'll drop it.

