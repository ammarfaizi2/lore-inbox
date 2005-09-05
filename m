Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVIEAFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVIEAFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIEAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:05:54 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:23626 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbVIEAFx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:05:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BDl0NxbB/29L3A+ga2s0Az5zpZ/Bn63ZyYl1p1ikKh2H0Xwbv0ZzT5Pm7AJuyJ4VRwFkCK2zIaKkjPzeR8lyDFJF5UdwqxAQXb+4oYlKLuz+5cJjdqhJc2lsBhSuAPYrVsup2JpyxXacAhJ7MzB2kKOWs1RE2fH+KzePByhpf4o=
Message-ID: <9a87484905090417057f755434@mail.gmail.com>
Date: Mon, 5 Sep 2005 02:05:49 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] disable_local_APIC() is only available when CONFIG_X86_LOCAL_APIC is defined
Cc: Hariprasad Nellitheertha <hari@in.ibm.com>
In-Reply-To: <200509050157.52344.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509050157.52344.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> 
> `disable_local_APIC' is only available when CONFIG_X86_LOCAL_APIC is defined :
> 
> arch/i386/kernel/crash.c: In function `crash_nmi_callback':
> arch/i386/kernel/crash.c:153: warning: implicit declaration of function `disable_local_APIC'
> arch/i386/kernel/crash.c: In function `nmi_shootdown_cpus':
> arch/i386/kernel/crash.c:195: warning: implicit declaration of function `disable_local_APIC'
> 
> There may be a better fix, but the below seems to do the trick.
> 
[snip]

I guess the better fix is to just provide a dummy function in the case
of CONFIG_X86_LOCAL_APIC not being defined.
If so, just let me know and I'll cook up a patch to do that, instead
of the ugly ifdef's.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
