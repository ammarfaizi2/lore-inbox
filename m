Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTEMUHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTEMUHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:07:36 -0400
Received: from SCULLY.TRAFFORD.DEMENTIA.ORG ([128.2.245.230]:50116 "EHLO
	scully.trafford.dementia.org") by vger.kernel.org with ESMTP
	id S262285AbTEMUGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:06:37 -0400
Date: Tue, 13 May 2003 16:19:13 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
X-X-Sender: shadow@scully.trafford.dementia.org
To: David Howells <dhowells@cambridge.redhat.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG
 support
In-Reply-To: <9828.1052852002@warthog.warthog>
Message-ID: <Pine.LNX.4.53.0305131615440.12539@scully.trafford.dementia.org>
References: <9828.1052852002@warthog.warthog>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, David Howells wrote:

> > >  (2) gettok(const char *fs, const char *key, size_t size, void *buffer)
> > >
> > >      Get a copy of an authentication token.
> >
> > Not sure what the use of this is for userspace. I can see how your
> > kernel module would use it.
>
> OpenAFS has it, but I'm not sure what uses it.

The simplest case: "List my tokens" (if you want any sort of detail about
them). A program "tokens" does just this, lists all tokens you have, then
enumerates with GetToken to get each and print some information about them
(are they expired, for instance).

There are also some debugging tools which can pull tokens back out and
decode them using the server key, and some old primitive authentication
passing stuff which is probably now all obsolete did also.


