Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVC1U3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVC1U3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVC1U3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:29:32 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:47373 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S261215AbVC1U33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:29:29 -0500
In-Reply-To: <20050328193933.GH943@vanheusden.com>
References: <20050328172820.GA31571@linux.ensimag.fr> <20050328175614.GG943@vanheusden.com> <Pine.LNX.4.61.0503282131560.11428@yvahk01.tjqt.qr> <20050328193933.GH943@vanheusden.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a1212af498cc4d77373b7be0db524347@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: forkbombing Linux distributions
Date: Mon, 28 Mar 2005 22:35:00 +0200
To: folkert@vanheusden.com
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 28, 2005, at 9:39 PM, folkert@vanheusden.com wrote:

On Mar 28, 2005, at 9:39 PM, folkert@vanheusden.com wrote:

>> I already posted one, posts ago.
>>>> [snip]
>>> Imporved version:
>>> [snip]
>>> char *dummy = (char *)malloc(1);
>> That cast is not supposed to be there, is it? (To pretake it: it's 
>> bad.)
>
> What is so bad about it?

Read the FAQ at http://www.eskimo.com/~scs/C-faq/q7.7.html

Malloc() returns a void*, so casts are superfluous if stdlib.h is 
included (as it should be). Hence if one typecasts the result of malloc 
in order to suit any particular type, the real bug is probably a 
lacking "#iinclude <stdlib.h>", which the cast (effectively) is hiding.



