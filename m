Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUFOX72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUFOX72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUFOX72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:59:28 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:2965 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S266023AbUFOX70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:59:26 -0400
In-Reply-To: <8666.1087292194@redhat.com>
References: <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Tue, 15 Jun 2004 19:59:06 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15, 2004, at 05:36, David Howells wrote:
> You might want to look at this patch. It's what I've come up with to 
> support
> kafs, but it's general, and should work for anything. It's been built 
> along
> Linus's guidelines, and has Linus's approval, contingent on something 
> actually
> using it fully.

One other thing that I'm not certain about in this patch is if there
is actually an important difference between "process" and
"session" key-rings.  I believe that the "session" distinction
should be left up to user-space software like PAM to determine
which key-ring "session" a process should belong to.  The user
and group key-rings are a good idea, so I guess the order with
which key-rings are checked for keys is:
	Thread
	Process
	Session???
	User
	Group

Cheers,
Kyle Moffett

