Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbWHDPzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWHDPzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWHDPzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:55:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18871 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161262AbWHDPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:55:22 -0400
Message-ID: <44D36E8B.4040705@sgi.com>
Date: Fri, 04 Aug 2006 17:58:03 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>	 <44BE9E78.3010409@garzik.org>  <yq0lkq4vbs3.fsf@jaguar.mkp.net>	 <1154702572.23655.226.camel@localhost.localdomain>	 <44D35B25.9090004@sgi.com> <1154706687.23655.234.camel@localhost.localdomain>
In-Reply-To: <1154706687.23655.234.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-04 am 16:35 +0200, ysgrifennodd Jes Sorensen:
>> The proposed patch makes it u1 - if we end up with arch specific
>> defines, as the patch is proposing, developers won't know for sure what
>> the size is and will get alignment wrong. That is not fine.
> 
> The _Bool type is up to gcc implementation details.

Which is even worse :(

>> If we really have to introduce a bool type, at least it has to be the
>> same size on all 32 bit archs and the same size on all 64 bit archs.
> 
> You don't use bool for talking to hardware, you use it for the most
> efficient compiler behaviour when working with true/false values.

Thats the problem, people will start putting them into structs, and
voila all alignment predictability has gone out the window.

Regards,
Jes
