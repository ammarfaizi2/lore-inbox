Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUJNTDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUJNTDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJNTAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:00:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:47768 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267345AbUJNS7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:59:06 -0400
Message-ID: <416ECA78.6020405@osdl.org>
Date: Thu, 14 Oct 2004 11:50:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Zarochentsev <zam@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] MS_VERBOSE handling in get_sb_bdev()
References: <20041014160638.GD25932@backtop.namesys.com>
In-Reply-To: <20041014160638.GD25932@backtop.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:
> Hello,
> 
> Anybody knows why the "silent" agrument of the fs' ->fill_super() routines is
> passed as ((flags & MS_VERBOSE) ? 1 : 0) ?.  It should be !(flags & MS_VERBOSE)
> instead, yes?
> 
> I don't belive the bug is not known... 

I saw several of those about 1 year ago when I updated Al's
fs option patches and got them merged.

They should be fixed IMO, but it's low priority, they work ("it ain't
broke so don't fix it"), and maybe someone else thinks that there is
no problem at all, i.e., they aren't broken at all...

-- 
~Randy
