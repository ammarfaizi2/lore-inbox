Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTEMPjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTEMPjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:39:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29702 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261417AbTEMPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:39:52 -0400
Date: Tue, 13 May 2003 08:52:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
In-Reply-To: <8624.1052840360@warthog.warthog>
Message-ID: <Pine.LNX.4.44.0305130849480.1562-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 May 2003, David Howells wrote:
> 
>  (1) PAG (Process Authentication Group) support. A PAG is ID'd by a unique
>      number, and is represented in memory as a structure that has a ring of
>      associated authentication tokens.
> 
>      Each process can either be part of a PAG, or it can PAG-less - in which
>      case it has no authentication tokens.
> 
>      Two new syscalls are added: setpag and getpag.

I think the code looks pretty horrible, but I think we'll need something
like this to keep track of keys. However, I'm not sure we should make this
a new structure - I think we should make the current "tsk->user" thing
_be_ the "PAG". 

		Linus

