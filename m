Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTKZVYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTKZVYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:24:18 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:23681 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264325AbTKZVYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:24:17 -0500
Date: Wed, 26 Nov 2003 21:24:06 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-ID: <20031126212406.GL14383@mail.shareable.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com> <20031126202216.GA13116@thunk.org> <20031126130254.010440e5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126130254.010440e5.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> > that are currently requesting timestamps, then we can dispense with
> > taking the timestamp.
> 
> You can predict what the arguments will be for the user's
> recvmsg() system call at the time of packet reception?  Wow,
> show me how :)

recvmsg() doesn't return timestamps until they are requested
using setsockopt(...SO_TIMESTAMP...).

See sock_recv_timestamp() in include/net/sock.h.

-- Jamie
