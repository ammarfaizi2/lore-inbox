Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUJLBqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUJLBqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUJLBqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:46:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50087 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266892AbUJLBqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:46:19 -0400
Message-ID: <416B375B.2010508@us.ibm.com>
Date: Mon, 11 Oct 2004 18:46:03 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
CC: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [patch] drm core internal versioning..
References: <Pine.LNX.4.58.0410100050160.6083@skynet>
In-Reply-To: <Pine.LNX.4.58.0410100050160.6083@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> An issue raised by DRM people with the new drm core is how to stop users
> shotting themselves in the foot when upgrading drm modules from CVS and
> mixing up cores and drivers...
> 
> This patch (against DRM CVS) proposes a simple internal version that gets
> passed from the module to the core, when built in-kernel, it gets set to
> default DRM_INTERNAL_VERSION_KERNEL, when built in DRM CVS or snapshot, it
> gets DRM_INTERNAL_VERSION_EXTERNAL, a core built in one will refuse to
> load a module build in the other..
> 
> This is quite a simple solution that should stop the most obvious issue,
> it doesn't stop people updating CVS drivers on top of themselves but my
> view is anyone doing this is either following our scripts or knows what
> they are doing...

I guess I don't get it.  We want to prevent a DRM module that requires 
core API N with a drm_core that exports M, M != N, right?  So why not do 
that?  In that model don't you just need DRM_INTERNAL_VERSION?  With the 
setup you propose it seems like we could still have problems.  If a user 
installs a snapshot, then installs just a DRM from a later snapshot, etc.
