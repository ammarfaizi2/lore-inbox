Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVLMOLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVLMOLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVLMOLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:11:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:1243 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964876AbVLMOLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:11:35 -0500
Message-ID: <439ED68C.5010605@us.ibm.com>
Date: Tue, 13 Dec 2005 09:11:24 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: chrisw@osdl.org, dwmw2@infradead.org, jamie@shareable.org,
       serue@us.ibm.com, mingo@elte.hu, linuxram@us.ibm.com, jmorris@namei.org,
       sds@tycho.nsa.gov, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 7/9] unshare system call : allow unsharing of namespace
References: <1134442736.14136.128.camel@hobbs.atlanta.ibm.com> <20051213135205.GP27946@ftp.linux.org.uk>
In-Reply-To: <20051213135205.GP27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Mon, Dec 12, 2005 at 10:00:09PM -0500, JANAK DESAI wrote:
>  
>
>>[PATCH -mm 7/9] unshare system call: allow unsharing of namespace
>>    
>>
>
>You need a pointer to new fs_struct, since that's what will be modified.
>As it is, you are modifying ->root, etc. of old fs_struct, which is OK
>only when it's not shared.
>
>	What you need is to pass new_fs ? new_fs : current->fs as a separate
>argument to your dup_namespace().
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Thanks. I will make all the changes as per your feedback, re-test and 
resubmit the
series later today.

-Janak
