Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264107AbUDVPAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbUDVPAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDVPAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:00:11 -0400
Received: from zero.aec.at ([193.170.194.10]:59403 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264107AbUDVPAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:00:06 -0400
To: James Morris <jmorris@redhat.com>
cc: linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Large inlines in include/linux/skbuff.h
References: <1NvJL-1QO-9@gated-at.bofh.it> <1NAJr-61F-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 22 Apr 2004 16:59:41 +0200
In-Reply-To: <1NAJr-61F-3@gated-at.bofh.it> (James Morris's message of "Thu,
 22 Apr 2004 03:00:09 +0200")
Message-ID: <m3y8ooawiq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> writes:

> On Wed, 21 Apr 2004, Denis Vlasenko wrote:
>
>> What shall be done with this? I'll make patch to move locking functions
>> into net/core/skbuff.c unless there is some reason not to do it.
>
> How will these changes impact performance?  I asked this last time you 
> posted about inlines and didn't see any response.

I don't think it will be an issue. The optimization guidelines
of AMD and Intel recommend to move functions that generate 
more than 30-40 instructions out of line. 100 instructions 
is certainly enough to amortize the call overhead, and you 
safe some icache too so it may be even faster.

-Andi

