Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWJ0WBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWJ0WBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWJ0WBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:01:51 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:58869 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750739AbWJ0WBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:01:50 -0400
Message-ID: <45427FEB.1000509@oracle.com>
Date: Fri, 27 Oct 2006 14:53:47 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, gregkh <greg@kroah.com>,
       sam@ravnborg.org, Ankita Garg <ankita@in.ibm.com>
Subject: Re: [PATCH 2/2] kconfig.debug menu dependencies
References: <20061027120837.f694814d.randy.dunlap@oracle.com> <20061027132353.f280e854.akpm@osdl.org>
In-Reply-To: <20061027132353.f280e854.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 27 Oct 2006 12:08:37 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>> DEBUG_FS, HEADERS_CHECK, and UNWIND don't depend on DEBUG_KERNEL but
>> they were stuck into the middle of the DEBUG_KERNEL menu, so move
>> them up above it (since it continues wherever lib/Kconfig.debug was
>> sourced into, hence below it won't work).
>>
>> Also make LKDTM depend on DEBUG_KERNEL, as other test modules do
>> (e.g., RT MUTEX TESTER, RCU TORTURE TEST).
> 
> This conflicts fairly seriously with the below.

actually they are basically equivalent, so no worries.

-- 
~Randy
