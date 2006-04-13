Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWDMWxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWDMWxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDMWxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:53:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62673 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751128AbWDMWxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:53:36 -0400
Date: Fri, 14 Apr 2006 00:53:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: tyler@agat.net
cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] Kmod optimization
In-Reply-To: <20060413190412.GA30541@Starbuck>
Message-ID: <Pine.LNX.4.64.0604140048160.17704@scrub.home>
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de>
 <20060413183617.GB10910@Starbuck> <20060413185014.GA27130@suse.de>
 <20060413190412.GA30541@Starbuck>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Apr 2006, tyler@agat.net wrote:

> Well perhaps I don't understand the mechanism :) But let's take an
> example.
> On all kernels (even recent), if the module smbfs is loaded, it's not
> handled by udev and request_module could be called.

No, it can't. If the smbfs is loaded, get_fs_type() will find it and won't 
even try to load it.
Do you a real example, where this is a problem?

bye, Roman
