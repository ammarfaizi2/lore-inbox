Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967752AbWLEX2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967752AbWLEX2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967758AbWLEX2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:28:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48594 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967752AbWLEX2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:28:37 -0500
Message-ID: <4575FFB1.2080500@redhat.com>
Date: Tue, 05 Dec 2006 18:24:33 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: ray-gmail@madrabbit.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <1165297363.29784.54.camel@localhost.localdomain>	 <45750FB6.8000304@redhat.com> <2c0942db0612050828s1780acefu53dcfd31c88116c0@mail.gmail.com>
In-Reply-To: <2c0942db0612050828s1780acefu53dcfd31c88116c0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> On 12/4/06, Kristian Høgsberg <krh@redhat.com> wrote:
>> Ok... I was planning to make big-endian versions of the structs so 
>> that the
>> endian issue would be solved.  But if the bit layout is not consistent, I
>> guess bitfields are useless for wire formats.  I didn't know that 
>> though, I
>> thought the C standard specified that the compiler should allocate 
>> bits out of
>> a word using the lower bits first.
> 
> The C standard explicitly allows it to be implementation defined.
> Having been bit by this exact problem, I can also recommend never
> using bitfields for anything other than things kept solely in local
> memory.

Yeah, I just read that paragraph in K&R... sigh.  Bitfields make the code so 
readable, though :)  Anyway, I'll rewrite it to use good old shifting and masking.

Kristian


