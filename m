Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292867AbSCEFep>; Tue, 5 Mar 2002 00:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292894AbSCEFef>; Tue, 5 Mar 2002 00:34:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292867AbSCEFeR>; Tue, 5 Mar 2002 00:34:17 -0500
Message-ID: <3C8458CA.30203@zytor.com>
Date: Mon, 04 Mar 2002 21:34:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <200203050440.XAA07022@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

> bcrl@redhat.com said:
> 
>>From your explanation of things, you only need to do the memsets once
>>at  startup of UML where the ram is allocated -> a uml booted with
>>64MB of  ram would write into every page of the backing store file
>>before even  running the kernel.  Doesn't that accomplish the same
>>thing?
>>
> 
> Sort of, but it's very heavy-handed.  The UML will force memory to be
> allocated on the host long before it will ever be needed, and it may never
> be needed.  This patch doesn't waste memory like that.
> 


This is not necessarily a bad thing, however.  If the user hadn't set up 
enough swap, they're probably better off getting the error message early.

	-hpa



