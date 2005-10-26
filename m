Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVJZJP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVJZJP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVJZJP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:15:29 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:55225 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932568AbVJZJP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:15:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=BZVIHmb74bs5hbHFZqREvSijJfzuQxuM+KQcnyNGcfV66OYjGuOT8DSLF32PYfTz4JOKU/9Mc3u1Iue7wN+TIM706EPDIVWZQCPserYoShaTkQk222DUJJIXycM3yoiyc2K3bz9F1YM0Jy0DZqIh6yfHKLKpkIESKCHSx8B1GHY=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/6] Uml - reuse i386 cpu-specific tuning
Date: Wed, 26 Oct 2005 11:19:30 +0200
User-Agent: KMail/1.8.3
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051025221105.21106.95194.stgit@zion.home.lan> <20051026002200.1ebb06f2.akpm@osdl.org>
In-Reply-To: <20051026002200.1ebb06f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261119.30429.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 09:22, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> >  arch/i386/Kconfig      |  304
> > ------------------------------------------------ arch/i386/Kconfig.cpu  |
> >  305 ++++++++++++++++++++++++++++++++++++++++++++++++
>
> Have mercy.  I currently have twelve patches which alter arch/i386/Kconfig
> and this patch conflicts with most of them.  This shouldn't come as a
> surprise - Kconfig files are oft-patched, and this is x86.

Yep - if we get no objection with this, I could pull any changes in -mm and 
merge the patch directly Linuswards at some point, since it has so many 
conflicts.

So, you can probably leave what you have there.
> What I did was to simply copy the large block between

> 	if !X86_ELAN
>
> and
>
> 	config X86_OOSTORE
>
> over into Kconfig.cpu, taking the modifications with it.

I also took X86_TSC with me, in my patch.

> As long as that's also what you did things should work OK.  If you actually
> made any changes as you did the copy-and-paste, we're screwed.

No, I didn't do real changes - I just added a couple of comments. However yes, 
should have splitout in copy+paste and changes

+# Put here option for CPU selection and depending optimization
[...]
and the comment near "endif" to say what is it closing:
+#!X86_ELAN

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
