Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVCVPJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVCVPJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCVPJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:09:21 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:57263 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261349AbVCVPIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:08:51 -0500
Subject: Re: [PATCH] don't do pointless NULL checks and casts before
	kfree() in security/
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Chris Vance <cvance@nai.com>,
       Wayne Salamon <wsalamon@nai.com>, James Morris <jmorris@redhat.com>,
       dgoeddel@trustedcs.com, Karl MacMillan <kmacmillan@tresys.com>,
       Frank Mayer <mayerf@tresys.com>, selinux@tycho.nsa.gov,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 22 Mar 2005 10:00:29 -0500
Message-Id: <1111503629.15346.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-20 at 13:29 +0100, Jesper Juhl wrote:
> kfree() handles NULL pointers, so checking a pointer for NULL before 
> calling kfree() on it is pointless. kfree() takes a void* argument and 
> changing the type of a pointer before kfree()'ing it is equally pointless.
> This patch removes the pointless checks for NULL and needless mucking 
> about with the pointer types before kfree() for all files in security/* 
> where I could locate such code.
> 
> The following files are modified by this patch:
> 	security/keys/key.c
> 	security/keys/user_defined.c
> 	security/selinux/hooks.c
> 	security/selinux/selinuxfs.c
> 	security/selinux/ss/conditional.c
> 	security/selinux/ss/policydb.c
> 	security/selinux/ss/services.c
> 
> (please keep me on CC if you reply)
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

The diffs to selinux look fine to me, and the resulting kernel seems to
be operating without problem.  Feel free to send along to Andrew Morton.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


