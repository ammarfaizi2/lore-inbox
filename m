Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVIHWIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVIHWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVIHWIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:08:16 -0400
Received: from quark.didntduck.org ([69.55.226.66]:12190 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965026AbVIHWIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:08:15 -0400
Message-ID: <4320B69D.5010901@didntduck.org>
Date: Thu, 08 Sep 2005 18:09:33 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consistently use the name asm-offsets.h
References: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> The existing ia64 specific rule to generate offsets.h
> has to "echo #define IA64_TASK_SIZE 0 > include/asm-ia64/offsets.h"
> before building asm-offsets.s to avoid compilation errors.
> 
> So long as you take care of this somehow in the generic version, go wild.
> 

The right fix is to get rid of that god-awful circular dependency on 
offset.h

--
				Brian Gerst
