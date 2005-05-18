Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVERQxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVERQxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVERQwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:52:05 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:8832 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262334AbVERQp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:45:58 -0400
Message-ID: <428B7143.4090607@ammasso.com>
Date: Wed, 18 May 2005 11:45:55 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Christopher Li <lkml@chrisli.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org>
In-Reply-To: <20050518132417.GA14488@64m.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li wrote:

> I think I know that it is. There is a "-nostdinc" in the sparse
> options, which I saw it in the other email you send out. It
> drop the internal include path. Gcc is does the same thing.
> 
> gcc -c -nostdinc /tmp/test.c
> /tmp/test.c:1:22: no include path in which to find stdarg.h

That option is set in the a_flags variable.  I'm looking through the kbuild files 
(Makefile, etc) to see why a_flags is being used to build my driver.

As far as I'm concerned, this is a bug in kbuild, and I think it only shows up with 
external modules.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
