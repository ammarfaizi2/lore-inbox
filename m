Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWEIJhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWEIJhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWEIJhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:37:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27819 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751721AbWEIJhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:37:08 -0400
Date: Tue, 9 May 2006 10:37:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 4/6] Kprobes: Insert probes on non-memory resident pages
Message-ID: <20060509093707.GC26953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, suparna@in.ibm.com,
	richardj_moore@uk.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com> <20060509070911.GD22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509070911.GD22493@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:39:11PM +0530, Prasanna S Panchamukhi wrote:
> User-space probes also supports the registering of the probe points
> before the probed code is loaded. This clearly has advantages for
> catching initialization problems. This involves modifying the probed
> applications address_space readpage() and readpages().

Patching file-system provided method tables is completely non-acceptable.
Exactly to prevent idiots like you from doing this we've started to mark
them const.

