Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVLMQcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVLMQcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLMQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:32:31 -0500
Received: from ns.suse.de ([195.135.220.2]:6850 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932348AbVLMQcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:32:31 -0500
Message-ID: <439EF797.1060102@suse.de>
Date: Tue, 13 Dec 2005 17:32:23 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Xen merge mainline list <xen-merge@lists.xensource.com>
Subject: Re: [Xen-merge] [patch] SMP alternatives for i386
References: <439EE742.5040909@suse.de> <439EEA67.6010706@vmware.com>
In-Reply-To: <439EEA67.6010706@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Overall technically, I like this patch.  Philosophically, I agree with 
> it as well - but might I strongly suggest that you avoid the .section 
> .previous directives and use the nestable .pushsection, .popsection 
> instead?  We are almost to the complexity point with fault handling and 
> alternatives that we will need nested section overrides.

Fortunaly we don't need that at the moment.  And in case we'll really 
need it some day it will not be *that* easy.  The pointers in the fixup 
section will point to the wrong location because we run the UP code not 
in-place but copy it to another address ...

cheers,

   Gerd

