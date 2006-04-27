Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWD0QSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWD0QSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWD0QSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:18:46 -0400
Received: from main.gmane.org ([80.91.229.2]:49566 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965164AbWD0QSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:18:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Roman Kononov <kononov195-far@yahoo.com>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 11:17:58 -0500
Message-ID: <e2qqrm$1e7$1@sea.gmane.org>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-255-17-86.dsl.emhril.ameritech.net
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2006 15:02, Gary Poppitz wrote:
>> We know they are "incompatible", why else would we allow "private" and
>> "struct class" in the kernel source if we some how expected it to work
>> with a C++ compiler?
> 
> 
> I can see that this was intentional, not an oversight.
> 
> If there is a childish temper tantrum mentality about C++ then I have no 
> reason or desire to be on this list.
> 
> Grow up.

Please let me summarize:
	1) Many people are more efficient writing C++ modules.
	2) It does not make sense to rewrite existing C code in
	   another language.
	3) Kernel H-files are not compilable by g++.
	4) The H-files use C++ keywords.
	5) The H-files use member initialization syntax, unsupported
	   by g++.
	6) The H-files use empty structures which are not empty in
	   g++.

4), 5) and 6) are to be fixed if we want to be g++-friendly. I am not 
aware of any other issues. Features like static constructors and 
exceptions are not strictly necessary for successful C++ programming.

4) must be trivial.
5) is less trivial but still doable. Can we ask g++ folks?
6) looks rather painful.

What do you think?

Regards
Roman

