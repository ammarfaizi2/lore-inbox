Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263479AbUJ2T5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbUJ2T5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUJ2TzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:55:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46772 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261875AbUJ2Tr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:47:26 -0400
Message-ID: <41829E39.1000909@us.ibm.com>
Date: Fri, 29 Oct 2004 12:47:05 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Zehetbauer <thomasz@hostmaster.org>
CC: linux-kernel@vger.kernel.org,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: status of DRM_MGA on x86_64
References: <1099052450.11282.72.camel@hostmaster.org> <1099061384.11918.4.camel@hostmaster.org>
In-Reply-To: <1099061384.11918.4.camel@hostmaster.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer wrote:
> Hi again,
> 
> I have now changed Kconfig and successfully compiled, loaded and used
> DRI with a Matrox Millenium G550 on a dual Opteron system. I guess this
> is a pretty good test and I wonder if the problem has already been fixed
> or if it was limited to specific hard- or software.

The problem, which exists with most (all?) DRM drivers, is that data 
types are used in the kernel/user interface that have different sizes on 
LP32 and LP64.  If your kernel is 64-bit, you will have problems with 
32-bit applications.
