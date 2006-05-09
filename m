Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWEIWeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWEIWeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWEIWeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:34:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43412 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751223AbWEIWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:34:21 -0400
Date: Tue, 9 May 2006 23:34:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
Message-ID: <20060509223411.GA14753@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
	xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
	Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085147.903310000@sous-sol.org> <20060509151516.GA16332@infradead.org> <1147203309.19485.62.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147203309.19485.62.camel@basalt.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:35:09PM -0500, Hollis Blanchard wrote:
> These typedefs are a new hack to work around a basic interface problem:
> instead of explicitly-sized types, Xen uses longs and pointers in its
> interface. On PowerPC in particular, where we need a 32-bit userland
> communicating with a 64-bit hypervisor, those types don't work.
> 
> However, the maintainers are reluctant to switch the interface to use
> explicitly-sized types because it would break binary compatibility.
> These ugly "HANDLE" macros allow PowerPC to do what we need without
> affecting binary compatibility on x86.

this stuff needs to be fixed on x86 aswell.  if the xen people don't
even fix up their code because of silly abi concerns we should better
not merge it at all.

