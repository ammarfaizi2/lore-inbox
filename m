Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVBXWZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVBXWZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVBXWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:25:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20953 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262512AbVBXWZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:25:03 -0500
Message-ID: <421E546F.4070505@watson.ibm.com>
Date: Thu, 24 Feb 2005 17:25:51 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM: 4/10 CKRM: Full rcfs support
References: <20041129221548.GD19892@kroah.com> <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com> <20050224174230.GA10244@kroah.com>
In-Reply-To: <20050224174230.GA10244@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
>>>>+config RCFS_FS
>>>>+	tristate "Resource Class File System (User API)"
>>>>+	depends on CKRM
>>>>+	help
>>>>+	  RCFS is the filesystem API for CKRM. This separate configuration 
>>>>+	  option is provided only for debugging and will eventually disappear 
>>>>+	  since rcfs will be automounted whenever CKRM is configured. 
>>>>+
>>>>+	  Say N if unsure, Y if you've enabled CKRM, M to debug rcfs 
>>>>+	  initialization.
>>>>+
>>>
>>>So is this option going to stay around, or should it always be enabled
>>>if CKRM is enabled?  Why not just do that for the user?
>>
>>It may be a module, but yes, this should be auto-set in the future when
>>CKRM is enabled.
> 
> 
> Then fix it?  :)
> 
> greg k-h

Sounds like a case is being made to make CONFIG_RCFS a "y" and eliminate
the possibility of it being a loadable module ? If so, I don't think its 
a good idea. While a kernel may have CKRM enabled, the user may choose 
not to use it. In such a case, he should have the option of not loading 
the rcfs module.

How does one restrict the choices of a tristate variable to exclude just 
the N selection ? It wasn't clear from the kconfig-language.txt...any 
pointers appreciated.


-- Shailabh



