Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWALOHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWALOHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWALOHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:07:25 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:7883 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030313AbWALOHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:07:25 -0500
Message-ID: <43C6627C.4060302@us.ibm.com>
Date: Thu, 12 Jan 2006 09:06:52 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 2/10] unshare system call -v5 : system call handler
 function
References: <1137038992.7488.206.camel@hobbes.atlanta.ibm.com> <m1oe2irmsh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1oe2irmsh.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>JANAK DESAI <janak@us.ibm.com> writes:
>
>  
>
>>[PATCH -mm 2/10] unshare system call: system call handler function
>>
>>sys_unshare system call handler function accepts the same flags as
>>clone system call, checks constraints on each of the flags and invokes
>>corresponding unshare functions to disassociate respective process
>>context if it was being shared with another task.
>>    
>>
>
>I'm going to log my objection again that you have you are
>scrambling the sense of the bits as compare to clone and that
>is very confusing.
>
>
>Eric
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Thanks, I do understand your objection. In the document file describing 
the feature
I did mention the bit inversion as a source for confusion. However, I 
found the
alternatives to be even more confusing. I went back to the original 
discussion of
unshare interface on lkml in August of 2000 and in one of the posts 
Linus indicated
that it makes sense for unshare(CLONE_FILES) to undo the sharing done by
clone(CLONE_FILES). So I stuck with what I had in the patch posted in mid
December.

http://www.ussg.iu.edu/hypermail/linux/kernel/0008.3/0662.html

-Janak

