Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVC3WS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVC3WS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVC3WS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:18:59 -0500
Received: from 17.red-62-57-106.user.auna.net ([62.57.106.17]:30906 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S262451AbVC3WS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:18:57 -0500
Date: Thu, 31 Mar 2005 00:18:55 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: Andi Kleen <ak@muc.de>, linux kernel <linux-kernel@vger.kernel.org>
Cc: binutils@sources.redhat.com
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment
 register access)
In-Reply-To: <20050330210801.GA15384@lucon.org>
Message-ID: <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org>
 <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
 <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
 <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
 <20050330210801.GA15384@lucon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, H. J. Lu wrote:

> On Wed, Mar 30, 2005 at 07:57:28AM -0800, Linus Torvalds wrote:

>>> There is no such an instruction of "movl %ds,(%eax)". The old assembler
>>> accepts it and turns it into "movw %ds,(%eax)".
>>
>> I disagree. Violently. As does the old assembler, which does not turn
>> "mov" into "movw" as you say. AT ALL.
>
> I should have made myself clear. By "movw %ds,(%eax)", I meant:
>
> 	8c 18	movw   %ds,(%eax)
>
> That is what the assembler generates, and should have generated, for
> "movw %ds,(%eax)" since Nov. 4, 2004.

Could this be the reason for the reported slowdown in the last six months?

-- 

Pau
