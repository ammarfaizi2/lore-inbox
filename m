Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWBZVzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWBZVzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWBZVzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:55:50 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:63375 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751015AbWBZVzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:55:49 -0500
Message-ID: <440223D6.1060200@austin.rr.com>
Date: Sun, 26 Feb 2006 15:55:34 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cifs hang patch idea - reduce sendtimeo on socket
References: <43F3FA4E.2050608@austin.rr.com> <20060216205623.GA8784@stusta.de> <1140644100.9942.15.camel@kleikamp.austin.ibm.com> <20060226175152.GK3674@stusta.de>
In-Reply-To: <20060226175152.GK3674@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>>Steve and I think we have figured this out.  In some cases, CIFSSMBRead
>>was returning a recently freed buffer.
>>...
>>    
>>
>
>Thanks a lot!
>
>In my testing, this patch applied against 2.6.14-rc4 fixed all problems 
>I observed.
>  
>
Adrian,
Thanks for the info.  Our testing looked good too.

In the development tree for cifs we are working on reducing buffer usage 
(a good first
step is already checked in) and enabling additional important security 
features (NTLMv2 and
Kerberos for newer more secure clients and also an option to configure 
and mount for
allowing lanman and plaintext sessionsetup to allow mounts to older 
legacy servers).
