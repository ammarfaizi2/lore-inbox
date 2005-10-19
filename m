Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVJSAYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVJSAYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVJSAYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:24:43 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:3480 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932219AbVJSAYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:24:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=m92oMMQZ6i+F5xHn6ciZNCB94uTfYu+/tqYuWa2Hll4LDEUyRDQz3Tya3lew5mKAWRQgc6y3dOuNx8ZU9onayyWyNSptzJ79ddGb6UBeMOLspybZSMZt/NgannnuUMYaDvPaFKsLsJXV4JA4YNLqlLI6i3SwwAtoJ58xLVk2qR4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] build fix for uml/amd64
Date: Wed, 19 Oct 2005 02:26:02 +0200
User-Agent: KMail/1.8.2
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
References: <20051018214517.GD7992@ftp.linux.org.uk>
In-Reply-To: <20051018214517.GD7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510190226.03582.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 23:45, Al Viro wrote:
> 	Missing half of the [PATCH] uml: Fix sysrq-r support for skas mode
> We need to remove these (UPT_[DEFG]S) from the read side as well as the
> write one - otherwise it simply won't build.
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
>
> IMO it should go in before 2.6.14.  Jeff, could you ACK that?

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

and probably

Acked-by: Jeff Dike <jdike@addtoit.com>

(we already discussed this via IRC, but since I couldn't test the patch at the 
moment, I asked Jeff to send it in my place, and then I've been busy).

> diff -urN RC14-rc4-git4-hppfs-sparse/arch/um/include/sysdep-x86_64/ptrace.h
> RC14-rc4-git4-pending-1/arch/um/include/sysdep-x86_64/ptrace.h ---
> RC14-rc4-git4-hppfs-sparse/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-1
>0 21:36:17.000000000 -0400 +++
> RC14-rc4-git4-pending-1/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-16
> 03:10:04.000000000 -0400 @@ -183,10 +183,6 @@
>                  case RBP: val = UPT_RBP(regs); break; \
>                  case ORIG_RAX: val = UPT_ORIG_RAX(regs); break; \
>                  case CS: val = UPT_CS(regs); break; \
> -                case DS: val = UPT_DS(regs); break; \
> -                case ES: val = UPT_ES(regs); break; \
> -                case FS: val = UPT_FS(regs); break; \
> -                case GS: val = UPT_GS(regs); break; \
>                  case EFLAGS: val = UPT_EFLAGS(regs); break; \
>                  default :  \
>                          panic("Bad register in UPT_REG : %d\n", reg);  \

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
