Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWGESYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWGESYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWGESYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:24:39 -0400
Received: from main.gmane.org ([80.91.229.2]:1223 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964969AbWGESYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:24:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
Date: Wed, 05 Jul 2006 11:24:22 -0700
Message-ID: <8764ib29m1.fsf@benpfaff.org>
References: <20060705175725.GL1605@parisc-linux.org>
	<20060705111057.a03fbcec.akpm@osdl.org>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:j74bh439o+GS6ng/J++U/BcCUUE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 5 Jul 2006 11:57:25 -0600
> Matthew Wilcox <matthew@wil.cx> wrote:
>
>> As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
>> chipsets available.
>> 
>> ...
>>
>>  config AGP_SIS
>>  	tristate "SiS chipset support"
>> -	depends on AGP
>> +	depends on AGP && X86
>
> I never know what to do here.
>
> Sure, the driver will not be used on that architecture.  But there is some
> benefit in being able to cross-compile that driver on other architectures
> anyway.  Sometimes it will pick up missed #includes, sometimes printk
> mismatches, various other assumptions which might be OK for x86 right now
> but which might cause problems in the future.

Should we have a NONNATIVE config option analogous to
EXPERIMENTAL, so that it could be expressed as
        depends on AGP && (X86 || NONNATIVE)
Seems to express the actual intentions.
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org

