Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWH0S1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWH0S1W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWH0S1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:27:21 -0400
Received: from gw.goop.org ([64.81.55.164]:14788 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932238AbWH0S1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:27:20 -0400
Message-ID: <44F1E405.6090208@goop.org>
Date: Sun, 27 Aug 2006 11:27:17 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
References: <20060827084417.918992193@goop.org> <44F1CC67.8040807@goop.org> <1156700663.3034.118.camel@laptopd505.fenrus.org> <200608272007.47741.ak@suse.de>
In-Reply-To: <200608272007.47741.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On AMD K7/K8 a segment register prefix is a single cycle penalty.
>
> I couldn't find anything in the Intel optimization manuals on it, but I assume
> it's also not dramatic.
>   

All I could find was:

    * avoid multiple prefixes (which was the least important guideline
      in instruction selection)
    * avoid using multiple segment registers (the pentium M only has one
      level of segment register renaming)
    * avoid prefixes which take the instruction length over 7 bytes

None of these apply to the use of %gs to access PDA.

Most of the discussion about prefixes is in avoiding the 0x66 16-bit prefix.

    J
