Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWFUMbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWFUMbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWFUMbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:31:55 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:64939 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751411AbWFUMbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:31:55 -0400
Date: Wed, 21 Jun 2006 08:24:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [-mm patch] binfmt_elf: fix checks for bad address
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <200606210828_MC3-1-C30B-9D84@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060619222512.58ba3e48.akpm@osdl.org>

On Mon, 19 Jun 2006 22:25:12 -0700, Andrew Morton wrote:

> On Tue, 20 Jun 2006 00:55:24 -0400
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > -#define BAD_ADDR(x) ((unsigned long)(x) > TASK_SIZE)
> > +#define BAD_ADDR(x) ((unsigned long)(x) >= TASK_SIZE)
>
> Convince us that this is correct for all the other users of BAD_ADDR() in
> this file.

Can I just wave my arms while asserting it's obvious?  It seemed that
way to me...

There are two more logical pieces to that patch in RHEL4 but those I
really didn't understand enough to post. Who's the binfmt_elf expert?

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
