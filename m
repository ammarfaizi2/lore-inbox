Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWBOUlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWBOUlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWBOUlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:41:40 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:21192 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932463AbWBOUlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:41:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ujjsfVrqcUZE/ySg9PRabC3jtNYQVwg/X01Pmb39/dvXckvZo4b/s2EJosXTTLaVF+HEhCCDwlte4LPksAc6NDgkFZw4FMotg8qRIUzoJ15mhAAN3Ss3HaQKnGCwUl4N5kY8qYdHedW2UlgGbd0+FZfVnAa2sAnPB5hEpTkXVpY=
Message-ID: <43F391E8.9050601@gmail.com>
Date: Thu, 16 Feb 2006 04:41:12 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Timothy Miller <theosib@gmail.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: HELP: Problem with radeonfb setting wrong resolution
References: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>	 <1139955612.7903.46.camel@localhost.localdomain>	 <9871ee5f0602141817p12617034o7f118710775cc73c@mail.gmail.com>	 <43F2BCF6.805@gmail.com> <9871ee5f0602150448j487dcd6nb20114bbd42a1dfa@mail.gmail.com>
In-Reply-To: <9871ee5f0602150448j487dcd6nb20114bbd42a1dfa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> On 2/15/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> 
>> Looks like an EDID problem.  Can you change #undef DEBUG to #define DEBUG
>> in drivers/video/fbmon.c and post your dmesg again?
> 
> You were right.  It's an edid problem.  I disabled DDC/I2C for Radeon,
> and the problem cleared right up.
> 

Something did come out from the DDC bus (as per radeonfb messages) but it
probably failed the checksum/header test so no extra messages were seen. 

Unless the EDID is totally bogus, this can be a fixable problem.  Can you
send me the EDID dump?  You can use the utility read-edid for this.

Tony

 
