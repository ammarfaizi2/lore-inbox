Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWFMVNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWFMVNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWFMVNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:13:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:7539 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932253AbWFMVNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:13:05 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=DEPPsY3MmB54UBZUsFABlfovKffExXkbEhTy1lHxqF/YUXnPDzXgAV/aHMvnJbcAZ
	ZTUf9IzidyJqWr6C9ZxNg==
Message-ID: <448F2A49.5020809@google.com>
Date: Tue, 13 Jun 2006 14:12:41 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bidulock@openss7.org
CC: Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org>
In-Reply-To: <20060613052215.B27858@openss7.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian F. G. Bidulock wrote:
> Stephen,
> 
> On Tue, 13 Jun 2006, Stephen Hemminger wrote:
> 
> 
>>>@@ -2176,3 +2279,13 @@ EXPORT_SYMBOL(sock_wake_async);
>>> EXPORT_SYMBOL(sockfd_lookup);
>>> EXPORT_SYMBOL(kernel_sendmsg);
>>> EXPORT_SYMBOL(kernel_recvmsg);
>>>+EXPORT_SYMBOL(kernel_bind);
>>>+EXPORT_SYMBOL(kernel_listen);
>>>+EXPORT_SYMBOL(kernel_accept);
>>>+EXPORT_SYMBOL(kernel_connect);
>>>+EXPORT_SYMBOL(kernel_getsockname);
>>>+EXPORT_SYMBOL(kernel_getpeername);
>>>+EXPORT_SYMBOL(kernel_getsockopt);
>>>+EXPORT_SYMBOL(kernel_setsockopt);
>>>+EXPORT_SYMBOL(kernel_sendpage);
>>>+EXPORT_SYMBOL(kernel_ioctl);
>>
>>Don't we want to restrict this to GPL code with EXPORT_SYMBOL_GPL?
> 
> 
> There are direct derivatives of the BSD/POSIX system call
> interface.  The protocol function pointers within the socket
> structure are not GPL only.  Why make this wrappered access to
> them GPL only?  It will only encourange the reverse of what they
> were intended to do: be used instead of the protocol function
> pointers within the socket structure, that currently carry no
> such restriction.

This has the makings of a nice stable internal kernel api.  Why do we want
to provide this nice stable internal api to proprietary modules?

Regards,

Daniel
