Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVJ3PWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVJ3PWT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVJ3PWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:22:19 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:16049 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750839AbVJ3PWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:22:18 -0500
Date: Sun, 30 Oct 2005 08:22:15 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static inline"
Message-ID: <20051030152215.GB9235@parisc-linux.org>
References: <20051030000301.GO4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030000301.GO4180@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:03:01AM +0200, Adrian Bunk wrote:
> "extern inline" doesn't make much sense.

Are you sure?  It used to.  Taking just one sample, pgd_none:

extern inline: alpha, parisc, s390
static inline: frv, ppc, sh64
define: arm, arm26, frv, h8300, m68knommu, ppc64, v850

I really don't think it makes any difference.  Such a function (returning
always 0) is always going to be inlined, and the only difference between
static inline and extern inline is what happens when it can't be inlined.
