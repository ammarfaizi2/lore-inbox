Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUD1F33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUD1F33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUD1F33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:29:29 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:45762 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264663AbUD1F3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:29:02 -0400
Date: Wed, 28 Apr 2004 15:18:35 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>
Subject: Re: What does tainting actually mean?
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Reply-To: ncunningham@linuxmail.org
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au> <408F3EE4.1080603@nortelnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr65ic90vshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <408F3EE4.1080603@nortelnetworks.com>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 28 Apr 2004 01:19:32 -0400, Chris Friesen  
<cfriesen@nortelnetworks.com> wrote:
> If only it were that easy.
>
> There has already been a case mentioned of a binary module that messed  
> up something that was only visible once that module was unloaded and  
> another one loaded.  It all depends totally on usage patterns.

I don't know what module you're talking about, but surely there must be  
something that could be done kernel-side to protect against such problems.  
Reference counting or such like? I guess if it was a hardware issue, but  
then again that might be an issue with too many assumptions being made  
about prior state? Maybe I am being too naive :>

> Binary modules, on the other hand, are often loaded up by users that  
> know just barely enough to download them and run an install script.  In  
> this case, it can be helpful to know up front that there has been  
> proprietary code running in kernel space, and aside from calls to kernel  
> APIs, we have no clue what else it was doing, what memory was being  
> trampled, what cpu registers were whacked, etc.

Now I see your point. Of course my previous point about patches is still  
valid though: the tainted flag only gives part of the picture. The person  
reporting the bug might create just as much of a black box for us by  
forgetting to mention that they applied patch foobar.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
