Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVCJJjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVCJJjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVCJJjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:39:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:39897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262478AbVCJJjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:39:00 -0500
Date: Thu, 10 Mar 2005 01:38:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-Id: <20050310013827.135f9c71.akpm@osdl.org>
In-Reply-To: <20050310091243.GA8632@muc.de>
References: <422C1EC0.8050106@yahoo.com.au>
	<422D468C.7060900@candelatech.com>
	<422DD5A3.7060202@rapidforum.com>
	<422F8A8A.8010606@candelatech.com>
	<422F8C58.4000809@rapidforum.com>
	<422F9259.2010003@candelatech.com>
	<422F93CE.3060403@rapidforum.com>
	<20050309211730.24b4fc93.akpm@osdl.org>
	<m1is3zvprz.fsf@muc.de>
	<20050310010955.000ea843.akpm@osdl.org>
	<20050310091243.GA8632@muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Thu, Mar 10, 2005 at 01:09:55AM -0800, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > In general to solve it one has to increase /proc/sys/vm/freepages
> > >  a lot.
> > 
> > /proc/sys/vm/min_free_kbytes
> 
> Oh yes, I still have the old 2.2 name in my finger tips
> 
> (never understood why these things need to be always renamed; I guess
> keeping the old name would have made it too easy on administrators) 
> 

Page sizes vary.  kbytes do not.  So scripts and documentation will work
correctly cross-platform, and when you change PAGE_SIZE.
