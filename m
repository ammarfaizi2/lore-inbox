Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWCJPtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWCJPtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWCJPtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:49:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36575 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751604AbWCJPte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:49:34 -0500
Date: Fri, 10 Mar 2006 15:49:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060310154925.GA5339@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Scott <nathans@sgi.com>, Suzuki <suzuki@in.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"linux-aio kvack.org" <linux-aio@kvack.org>,
	lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
	akpm@osdl.org, linux-xfs@oss.sgi.com
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310005020.GF1135@frodo>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 11:50:20AM +1100, Nathan Scott wrote:
> Something like this (works OK for me)...

Yeah, that should work for now.  But long-term we really need to redo
direct I/O locking to have a common scheme for all filesystems.  I've heard
birds whistling RH patches yet another scheme into RHEL4 for GFS an it's
definitly already far too complex now.

