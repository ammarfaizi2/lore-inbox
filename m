Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279279AbRJWGXY>; Tue, 23 Oct 2001 02:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279278AbRJWGXO>; Tue, 23 Oct 2001 02:23:14 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17925 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279279AbRJWGWy>;
	Tue, 23 Oct 2001 02:22:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Brian Gerst <bgerst@didntduck.org>
Cc: george anzinger <george@mvista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How should we do a 64-bit jiffies? 
In-Reply-To: Your message of "Tue, 23 Oct 2001 02:05:54 -0400."
             <3BD508C2.3A0DB6C2@didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Oct 2001 16:23:04 +1000
Message-ID: <1898.1003818184@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001 02:05:54 -0400, 
Brian Gerst <bgerst@didntduck.org> wrote:
>Keith Owens wrote:
>> You will need a spin lock around that on 32 bit systems, but that is
>> true for anything that tries to do 64 bit counter updates on a 32 bit
>> system.
>
>cmpxchg8b does, but it's a bit indirect.

Not on 386, only on 486 and above.  Besides, you want to avoid arch
specific asm code.

