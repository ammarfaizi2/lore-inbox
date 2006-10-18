Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWJRNPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWJRNPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWJRNPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:15:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:15820 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161004AbWJRNPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:15:31 -0400
From: Andi Kleen <ak@suse.de>
To: "bibo,mao" <bibo.mao@intel.com>
Subject: Re: [PATCH] x86_64 add NX mask for PTE entry
Date: Wed, 18 Oct 2006 15:15:25 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <4535F0A4.1090709@intel.com> <45360E99.7020001@intel.com> <453613F6.7020800@intel.com>
In-Reply-To: <453613F6.7020800@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181515.25372.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 13:45, bibo,mao wrote:
> Also I think change_page_attr is buggy. if orginal page is not
> large page, when that page's previous attr is reverted revert_page()
> function will be called to make that page huge. Indeed I think
> there is no need to do this.

On x86-64 all pages in the direct mapping are initially large pages.
On i386 not necessarily, but it deals with that.

-Andi

