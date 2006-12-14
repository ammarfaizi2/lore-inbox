Return-Path: <linux-kernel-owner+w=401wt.eu-S932690AbWLNMg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWLNMg2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWLNMg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:36:28 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1621 "EHLO
	anchor-post-33.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932690AbWLNMg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:36:27 -0500
Message-ID: <45814544.1050102@superbug.co.uk>
Date: Thu, 14 Dec 2006 12:36:20 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Franck Pommereau <pommereau@univ-paris12.fr>, linux-kernel@vger.kernel.org
Subject: Re: Executability of the stack
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org>
In-Reply-To: <1166090244.27217.978.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2006-12-14 at 10:26 +0100, Franck Pommereau wrote:
>> Dear Linux developers,
>>
>> I recently discovered that the Linux kernel on 32 bits x86 processors
>> reports the stack as being non-executable while it is actually
>> executable (because located in the same memory segment).
> 
> this is not per se true, it depends on the capabilities of your 32 bit
> x86 processor.
> 
> 
>> # grep maps /proc/self/maps
>> bfce8000-bfcfe000 rw-p bfce8000 00:00 0          [stack]
> 
> this shows that the *intent* is to have it non-executable. 
> Not all x86 processors can enforce this. All modern ones do.
> 
>> Is there any reason for this situation? 
> 
> the alternative (showing effective permission) is equally confusing;
> apps would see permissions they didn't set...
> 

Why not show both.
"intent" and "effective".

