Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWEJHT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWEJHT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWEJHT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:19:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:30856 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964834AbWEJHT6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:19:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=M4Rkkrs8k+wwBqZ5rxb12YhoD/1Vyk3fPzxm9bEpCAmczCYhyjUjw8V7/MFEhCIgr1CW05hZZQDUlocbJgy4OJjVZX2rGIsyoiaQ5ZjweM8OtUj+focA4f4pT7J5c/8MjVbk6iMTyPYIW2VRMOVxwt19h++V5y9wqjBMY7pif3I=
Message-ID: <84144f020605100019i26e1c649m18c9b314b63dce@mail.gmail.com>
Date: Wed, 10 May 2006 10:19:57 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mike Kravetz" <kravetz@us.ibm.com>
Subject: Re: [PATCH] alloc_memory_early() routines
Cc: "Andrew Morton" <akpm@osdl.org>, "Dave Hansen" <haveblue@us.ibm.com>,
       "Christoph Lameter" <clameter@sgi.com>,
       "Andy Whitcroft" <apw@shadowen.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060509210722.GD3168@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060509053512.GA20073@monkey.ibm.com>
	 <20060508224952.0b43d0fd.akpm@osdl.org>
	 <20060509210722.GD3168@w-mikek2.ibm.com>
X-Google-Sender-Auth: ea41ee72ed780505
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Mike Kravetz <kravetz@us.ibm.com> wrote:
> I did not include support for 'large' allocations as suggested by
> Dave, or corresponding free_memory_early() routines.  The only
> immediate need is for NUMA/node aware allocation.  Others can be
> added as the needs arise.

Sorry if this was already discussed, but you're not supposed to free
the memory allocated by alloc_memory_early() ever? If so, please add a
kerneldoc stating that.

                                             Pekka
