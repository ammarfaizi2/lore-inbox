Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267910AbUHFXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267910AbUHFXIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268320AbUHFXIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:08:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267910AbUHFXIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:08:07 -0400
Date: Sat, 7 Aug 2004 00:07:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix some 32bit isms
Message-ID: <20040806230747.GX12308@parcelfarce.linux.theplanet.co.uk>
References: <20040728135941.GA17409@devserv.devel.redhat.com> <20040728092334.74e0cfcd.akpm@osdl.org> <cf125u$hnt$1@terminus.zytor.com> <20040806230305.GW12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806230305.GW12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 12:03:05AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > It should be %zu, since size_t is unsigned.
> > 
> > %zd is appropriate for ssize_t.
> 
> It's signed (and not a ssize_t, while we are at it).  If you want to be
> pedantic, use %td since we are dealing with ptrdiff_t here.

*Ugh*

We are not doing homegrown offsetof(), so it's really size_t.  My apologies.

Yes, that should be> %zu (OTOH, %zd will do the same unless we have 2Gb
struct somewhere ;-)
 
> BTW, we ought to add 't' modifier in vsnpritf()...
