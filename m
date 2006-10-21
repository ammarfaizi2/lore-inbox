Return-Path: <linux-kernel-owner+willy=40w.ods.org-S637741AbWJUSUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S637741AbWJUSUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S637743AbWJUSUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:20:35 -0400
Received: from mail.suse.de ([195.135.220.2]:24491 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S637741AbWJUSUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:20:34 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] [8/19] x86: Use -maccumulate-outgoing-args
Date: Sat, 21 Oct 2006 20:20:29 +0200
User-Agent: KMail/1.9.5
Cc: jbeulich@novell.com, patches@x86-64.org, linux-kernel@vger.kernel.org
References: <20061021651.356252000@suse.de> <20061021165128.23A8913C4D@wotan.suse.de> <20061021171848.GC30758@redhat.com>
In-Reply-To: <20061021171848.GC30758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610212020.29490.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 19:18, Dave Jones wrote:
> On Sat, Oct 21, 2006 at 06:51:28PM +0200, Andi Kleen wrote:
>  > 
>  > This avoids some problems with gcc 4.x and earlier generating
>  > invalid unwind information. In 4.1 the option is default
>  > when unwind information is enabled.
>  > 
>  > And it seems to generate smaller code too, so it's probably
>  > a good thing on its own. With gcc 4.0:
> 
> That's quite odd. The gcc man page mentions that 
> "The drawback is a notable increase in code size."
> for this option.  I wonder if this is just stale documentation,
> or there's a reason why we're special :)

I redid the measurements originally because someone else commented
on this too, but I still saw the same numbers.

If someone else wants to redo them too please do 
(note on gcc 4.1 you need to disable the stack unwinder or debug info
first, otherwise it is a nop) 

-Andi
