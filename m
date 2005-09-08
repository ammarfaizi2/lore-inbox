Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbVIHPR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVIHPR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbVIHPR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:17:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27841 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932687AbVIHPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:17:55 -0400
Date: Thu, 8 Sep 2005 16:17:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add stricmp
Message-ID: <20050908151754.GB11067@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43206F420200007800024455@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43206F420200007800024455@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:05:06PM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> While strnicmp existed in the set of string support routines, stricmp
> didn't, which this patch adjusts.

I don't thing we should do case-insenstitive comparims in kernel, and
in the few cases where we must (legacy OS fileystem support) it needs
to be NLS-capable.

But once again we need to see the users anyway.  You're adding tons of
bloat in your patches without showing us an actually useful user.
