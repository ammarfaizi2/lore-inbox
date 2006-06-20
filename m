Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWFTObe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWFTObe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWFTObe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:31:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:52856 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751106AbWFTObe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:31:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VrQxmHvEQCqg3ko5DzicOWcGqdBXenGynYw7md6tiQzHJQTg9hjNvLSafrEWItz2XM5pv19GJqMyXuLQIOmS74Wx+Bu7LBPbjNAEHaZBSqrs3/LsRTpi/eo2wQv9RrmMvhCd6ilGLxABs77LIy7BDRv/yoYxOOAqJH8j5gvHdys=
Message-ID: <449806B6.7060309@gmail.com>
Date: Tue, 20 Jun 2006 22:31:18 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
References: <44957026.2020405@gmail.com>	 <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>	 <44974AC7.4060708@gmail.com>	 <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>	 <4497B2B5.4040001@gmail.com> <9e4733910606200704n19da7833s6873eb3270fe299e@mail.gmail.com>
In-Reply-To: <9e4733910606200704n19da7833s6873eb3270fe299e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> No it can't.  Once the card is in graphics mode, vgacon cannot go to
>> text mode on its own.  It has to know how to write to other VGA
>> registers which are unique per hardware.
> 
> Might be a good place for a little call_usermodehelper example. VGAcon
> could try calling vbetool to save it's state and restore it. GregKH
> told me that the class firmware loader code was the place to start.
> 

Yes, that's part of the plan. I'm still looking for the best inteface
to do that. It must be a 2-way inteface, ie, kernel->user and user->kernel.
Does the firmware loader code satisfy the above condition?

Tony 
