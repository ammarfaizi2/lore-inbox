Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVJ3QWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVJ3QWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJ3QWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:22:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:14044 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751081AbVJ3QWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:22:38 -0500
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH] x86_64: Work around Re: 2.6.14-git1 (and -git2) build failure on AMD64
Date: Sun, 30 Oct 2005 17:23:31 +0100
User-Agent: KMail/1.8.2
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <16080000.1130681008@[10.10.2.4]> <200510301649.42064.ak@suse.de> <52br17nfmk.fsf@cisco.com>
In-Reply-To: <52br17nfmk.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301723.31561.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 17:17, Roland Dreier wrote:
>     Andi> Linus, can you please apply it?
> 
> No, please don't apply this.  The correct fix is to mark
> toshiba_ohci1394_dmi_table[] as __devinitdata in that file, as in the
> patch I posted here:
> 
>     http://lkml.org/lkml/2005/10/29/12

While not correct I don't see how it should guarantee it will
work around that gcc bug on all possible gcc versions (which show
different behaviour) My patch is more conservative and safer.

-Andi
