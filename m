Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSGYSSr>; Thu, 25 Jul 2002 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSGYSSr>; Thu, 25 Jul 2002 14:18:47 -0400
Received: from codepoet.org ([166.70.99.138]:61863 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315544AbSGYSSq>;
	Thu, 25 Jul 2002 14:18:46 -0400
Date: Thu, 25 Jul 2002 12:22:00 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
Message-ID: <20020725182200.GB4858@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Brad Hards <bhards@bigpond.net.au>,
	linux-kernel@vger.kernel.org
References: <aho5ql$9ja$1@cesium.transmeta.com> <200207252308.00656.bhards@bigpond.net.au> <3D4024A4.5090806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4024A4.5090806@zytor.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 25, 2002 at 09:17:40AM -0700, H. Peter Anvin wrote:
> Brad Hards wrote:
> >
> >I like it (having just argued for it), except for the __s* and __u*.
> >The ABI definitions aren't for kernel programmers. They are for 
> >userspace programmers. So we should use standard types,
> >even if they are a bit ugly (and uint16_t isn't really much uglier
> >than __u16, and at least it doesn't carry connotations of
> >something that is meant to be internal, which is what the standard
> >double-underscore convention means). 
> >
> 
> Not quite -- it means they are implementation-specific (in this case, 
> Linux-specific.)  The Linux __s* and __u* predates <stdint.h>; I 
> certainly would like to migrate to <stdint.h> but I don't see it as a 
> very high priority.

Using stdint.h types at least in the kernel ABI headers would be
a _huge_ improvement!  I hate having to cut-n-paste kernel structs 
into my user-spave code and then rework the types so user-space 
code can compile things.  

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
