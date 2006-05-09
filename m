Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWEIL63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWEIL63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWEIL63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:58:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56488 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932393AbWEIL62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:58:28 -0400
Date: Tue, 9 May 2006 12:58:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060509115826.GA2213@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
	Ian Pratt <ian.pratt@xensource.com>,
	Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
	netdev@vger.kernel.org
References: <20060509084945.373541000@sous-sol.org> <20060509085201.446830000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085201.446830000@sous-sol.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:00:34AM -0700, Chris Wright wrote:
> The network device frontend driver allows the kernel to access network
> devices exported exported by a virtual machine containing a physical
> network device driver.

Please don't add procfs code to new network drivers.  Especially if it's oopsable
like the code in this driver by simple device renaming.

