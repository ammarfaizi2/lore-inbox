Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbUBLGsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUBLGsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:48:41 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:31405 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266083AbUBLGsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:48:40 -0500
Date: Wed, 11 Feb 2004 22:48:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark de Vries <m.devries@nl.tiscali.com>, linux-kernel@vger.kernel.org
Subject: Re: About highmem in 2.6
Message-ID: <41130000.1076568516@[10.10.2.4]>
In-Reply-To: <402A7EC6.7010003@nl.tiscali.com>
References: <1o6EZ-2zO-27@gated-at.bofh.it> <1o7AZ-3PD-9@gated-at.bofh.it> <402A7EC6.7010003@nl.tiscali.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been using this patch for a while now on my box (with 1GB):
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa1/00_3.5G-address-space-5
> (kernel is 'vanilla' otherwise)
> 
> This allows you to use your full 1GB w/out highmem support.... (2G/2G user/kernel addr space split, or something..)
> 
> Anything (potentially) wrong/bad about this patch??

The only problem is that you lose some virtual address space for the user,
which isn't a problem for most people.
 
> Is there a simmilar patch for 2.6??

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.2/2.6.2-mjb1/212-config_page_offset

You might have to tweak the config stuff a tiny bit to get the patch to apply 
if you don't have 4/4 split in.

M.
