Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWDUSjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWDUSjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDUSjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:39:03 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:48521 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750863AbWDUSjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:39:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=N+EuCn/ejWl7503gIPR1MyheCqmkL1Vhm79s/Ybh5vqaGrA9H6/lMtLw+MqiczAatWGeiNq8cTSyKk9VnpOFf3/KcSF0wofnzhhGvW9PQmWrnzixT6VZWOoH1rJVDxS08MPwHGbiE/FfOAjXMlmSxpz82VXqJ8vGhqZw8p9KFt8=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Date: Fri, 21 Apr 2006 20:38:52 +0200
User-Agent: KMail/1.8.3
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com> <200604212016.36859.blaisorblade@yahoo.it>
In-Reply-To: <200604212016.36859.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212038.53323.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 20:16, Blaisorblade wrote:
> On Thursday 20 April 2006 11:05, Heiko Carstens wrote:

> The flags could be:
>
> MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set
> differently than the default).

Actually, for a more elegant API the default should be to check and there 
should be a flag PT_SC_MASK_IGNORE_UNKNOWN_SYSCALL (reworded in some clearer 
way, it doesn't mean to ignore the syscall but the bits - IGNORE should be 
something like "be comprehensive with me when you check". Maybe 
ACCEPT_UNKNOWN_SYSCALL).

> probably with a reasonable prefix to avoid namespace pollution (something
> like "PT_SC_-").

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
http://it.messenger.yahoo.com
