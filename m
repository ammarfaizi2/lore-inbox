Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSLFLaG>; Fri, 6 Dec 2002 06:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSLFLaG>; Fri, 6 Dec 2002 06:30:06 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:20232 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262373AbSLFLaE>; Fri, 6 Dec 2002 06:30:04 -0500
Date: Fri, 6 Dec 2002 11:37:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: GrandMasterLee <masterlee@digitalroadkill.net>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206113731.A31122@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>,
	GrandMasterLee <masterlee@digitalroadkill.net>,
	Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <3DF050EB.108DCF8@digeo.com> <1039160042.16565.15.camel@localhost> <3DF056EE.EA9ADE01@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF056EE.EA9ADE01@digeo.com>; from akpm@digeo.com on Thu, Dec 05, 2002 at 11:51:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:51:10PM -0800, Andrew Morton wrote:
> So at a guess, I'd say you're being hit by excessive stack use in
> the XFS filesystem.  I think the XFS team have done some work on that
> recently so an upgrade may help.

Yes, XFS 1.1 used a lot of stack.  XFS 1.2pre (and the stuff in 2.5)
uses much less.  He's also using the qla2xxx drivers that aren't exactly
stack-friendly either.

