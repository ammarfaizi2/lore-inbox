Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWIVV27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWIVV27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWIVV27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:28:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:56533 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932188AbWIVV26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:28:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=uULdZ7CIQAMR3HOxYQua4vYkg43GO3XI46TE8DsKAX+chUiVGFVhmY56yQV+IycSwoCF4quoqYXTnDNh7Uq1113v8NsLMQJG62jltr+59DRBBDNYYzwr+XzhsK9IoyblJDykYF5cpWaiOoCm8geGU8bbj9WP95k0BFwbVUmdwkk=
Message-ID: <c1bf1cf0609221428i618a5902g3d0315f6b0b9b79e@mail.gmail.com>
Date: Fri, 22 Sep 2006 14:28:57 -0700
From: "Ed Swierk" <eswierk@arastra.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [RETRY] [PATCH] load_module: no BUG if module_subsys uninitialized
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <20060922201637.GA17547@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c1bf1cf0609221248v39113875id4b48c62cec8eb46@mail.gmail.com>
	 <20060922201637.GA17547@kroah.com>
X-Google-Sender-Auth: aef8d820e3d47749
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Greg KH <greg@kroah.com> wrote:
> How are you calling load_module before this init call is made?

In my case, net-pf-1 is getting modprobed as a result of hotplug
trying to create a UNIX socket. Calls to hotplug begin after the
topology_init initcall.

--Ed
