Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWKBPTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWKBPTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWKBPT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:19:29 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:1306 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751344AbWKBPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:19:28 -0500
Message-ID: <454A0C7B.4080701@qumranet.com>
Date: Thu, 02 Nov 2006 17:19:23 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: "Hesse, Christian" <mail@earthworm.de>, kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] kvm howto
References: <4549F1D5.8070509@qumranet.com>	 <200611021527.09664.mail@earthworm.de> <454A0165.7090009@qumranet.com> <aec7e5c30611020714qe6bcc41ucc789e3a2ca85c1f@mail.gmail.com>
In-Reply-To: <aec7e5c30611020714qe6bcc41ucc789e3a2ca85c1f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 15:19:28.0146 (UTC) FILETIME=[49AE0720:01C6FE92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
>>
>> You need a newer binutils.  I'm using binutils-2.16.91.0.6 (gotta love
>> that version number), shipped with Fedora Core 5.
>
> The VT-extensions added by Intel and AMD only adds a limited number of
> instructions each. If you want to be user friendly it might be a good
> idea to implement these instructions as macros. I'm pretty sure
> VT-extension support in Xen works with my old binutils version.
>

Yes, Xen uses macros.

I figured a newish machine will have a newish binutils.  Looks like I 
was wrong.  I don't like uglifying the code, but if many users hit this, 
there won't be much of a choice.

[A minor problem with macros is that you can't let gcc choose the 
registers for you with instructions that have operands]

-- 
error compiling committee.c: too many arguments to function

