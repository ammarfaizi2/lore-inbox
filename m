Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVD0PML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVD0PML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVD0PML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:12:11 -0400
Received: from duempel.org ([81.209.165.42]:40851 "HELO duempel.org")
	by vger.kernel.org with SMTP id S261707AbVD0PMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:12:09 -0400
Date: Wed, 27 Apr 2005 17:10:40 +0200
From: Max Kellermann <max@duempel.org>
To: k8 s <uint32@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt Regarding Multithreading and Device Driver
Message-ID: <20050427151040.GA5717@roonstrasse.net>
Mail-Followup-To: k8 s <uint32@gmail.com>, linux-kernel@vger.kernel.org
References: <699a19ea050427080545fb1676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699a19ea050427080545fb1676@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/04/27 17:05, k8 s <uint32@gmail.com> wrote:
> I am storing something into struct file*filp->private_data.
> As this is not shared across processes I am not doing any locking
> stuff while accessing or putting anything into it.

You're talking about kernel variables, aren't you? Kernel memory is
shared among all processes, i.e. you _do_ need locking.

Max

