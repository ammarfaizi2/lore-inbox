Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWIVNDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWIVNDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWIVNDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:03:21 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:1969 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP id S932395AbWIVNDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:03:20 -0400
Message-ID: <4513DF11.802@grupopie.com>
Date: Fri, 22 Sep 2006 14:03:13 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Jiri Slaby <jirislaby@gmail.com>, Om Narasimhan <om.turyx@gmail.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>	 <20060921072017.GA27798@us.ibm.com>	 <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>	 <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com>	 <4513A21C.40704@gmail.com> <4513C9BF.7040706@grupopie.com> <84144f020609220503n4c495542x2130165e371ec85c@mail.gmail.com>
In-Reply-To: <84144f020609220503n4c495542x2130165e371ec85c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 9/22/06, Paulo Marques <pmarques@grupopie.com> wrote:
>> Agreed on every comment except this one. That complex expression is
>> really just a constant in the end, so there is no point in using kcalloc.
> 
> The code is arguably easier to read with kcalloc.

I was afraid the kcalloc call would have the added overhead of an extra 
parameter and a multiplication, but since it is actually declared as a 
static inline, gcc should optimize everything away (because both 
parameters are constants) and give the same result in the end.

So, its fine by me either way.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
