Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264032AbUD0VTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbUD0VTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUD0VTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:19:36 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:22021 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S264032AbUD0VTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:19:35 -0400
Date: Tue, 27 Apr 2004 17:19:26 -0400
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/11] sunrpc-xdr-words
Message-ID: <20040427211926.GA4319@fieldses.org>
References: <1082975183.3295.74.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082975183.3295.74.camel@winden.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:28:48PM +0200, Andreas Gruenbacher wrote:
> Encode 32-bit words in xdr_buf's
> +extern int read_u32_from_xdr_buf(struct xdr_buf *, int, u32 *);

Note that the same function is defined as a static inline in
net/sunrpc/auth_gss/svcauth_gss.c, so gcc will complain if
CONFIG_SUNRPC_GSS is also defined.

--Bruce Fields
