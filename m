Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265844AbUFOTAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUFOTAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUFOTAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:00:16 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:2967 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265844AbUFOTAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:00:10 -0400
In-Reply-To: <8666.1087292194@redhat.com>
References: <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3943FF92-BEFE-11D8-95EB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Tue, 15 Jun 2004 15:00:09 -0400
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
>
> You can use the session keyring number as a PAG ID if you wish.
>
> I've a sample aklog program (key submission) should you be interested.

One thing that I would very much like to have is the ability to create 
a new
shell with a new keyring, such that I can still see and use the old 
keyring,
but I can create new keys without modifying the old keyring, even to the
extent of masking out keys in the old keyring without modifying them for
other processes.  From my brief glance at your patch, that's not a 
feature
you have implemented.  I would also like the ability to mark a key as
unreadable except by kernel threads or processes with CAP_KEYRING.
If I can pass key "handles" of some sort over UNIX sockets, then I can
also pass an unreadable key to a daemon process which uses it to
access my files until I revoke the key.

Cheers,
Kyle Moffett

