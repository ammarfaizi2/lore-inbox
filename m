Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVDQSHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVDQSHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 14:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDQSHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 14:07:04 -0400
Received: from mail.shareable.org ([81.29.64.88]:20643 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261384AbVDQSG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 14:06:57 -0400
Date: Sun, 17 Apr 2005 19:06:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050417180636.GA22892@mail.shareable.org>
References: <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org> <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu> <a4e6962a05041710451d74f037@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a05041710451d74f037@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> I'd like to second that I think private-namespaces are the right way
> to solve this sort of problem.  It also helps not cluttering the
> global namespace with user-local mounts
> 
> >
> > Shared subtrees and more support in userspace tools is needed before
> > private namespaces can become really useful.
> > 
> 
> I'd like to talk about this a bit more and start driving to a solution
> here.  I've been looking at the namespace code quite a bit and was
> just about to dive in and start checking into adding/fixing certain
> aspects such as stackable namespaces, optional inheritence (changes in
> a parent namespace are reflected in the child but not vice-versa),
> etc.
> 
> One aspect I was thinking about here was a mount flag that would give
> you a new private namespace (if you didn't already have one) for the
> mount (and I guess that would impact any subsequent mounts from the
> user in that shell).  Another option would be a 'newns' style
> system-call, but I'm generally against adding new system calls.
> 
> Shared subtrees are a tricky one.  I know how we would handle it in
> V9FS, but not sure how well that would translate to others
> (essentially we'd re-export the subtree so other user's could mount it
> individually -- but that's a very Plan 9 solution and may not be what
> more UNIX-minded folks would want -- we also need to improve our own
> server infrastructure to more efficiently support such a re-export).
> 
> So, to sum up I think private namespaces is the right solution, and
> I'd rather put effort into making it more useful than work-around the
> fact that its not practical right now.

Have a chat with Al Viro, who has already done some work on shared
mounts and subtrees I think.

-- Jamie
