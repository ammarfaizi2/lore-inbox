Return-Path: <linux-kernel-owner+w=401wt.eu-S965316AbXAKIGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbXAKIGW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965323AbXAKIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:06:22 -0500
Received: from il.qumranet.com ([62.219.232.206]:57963 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965316AbXAKIGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:06:21 -0500
Message-ID: <45A5EFFC.2080609@qumranet.com>
Date: Thu, 11 Jan 2007 10:06:20 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] guest crash on 2.6.20-rc4
References: <ada4pr1mqz2.fsf@cisco.com> <45A40898.4040307@qumranet.com> <ada8xgay3b7.fsf@cisco.com>
In-Reply-To: <ada8xgay3b7.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  >  	if (is_writeble_pte(*shadow_ent))
>  > -		return 0;
>  > +		return 1;
>
> With this patch, it looks like my guest is surviving the load that
> triggered the oops before.  So I think this fixes the issue I saw as well.
> I assume you'll send this in for 2.6.20?
>   

The patch actually replaces one bug (guest pagefaults on writable dirty 
ptes, under certain conditions) with another, rarer one (spinning on a 
user-mode pagefault on writable dirty kernel ptes).  I'll do it right 
and re-test, then send for .20 along with a few friends.


-- 
error compiling committee.c: too many arguments to function

