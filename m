Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTFDAMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFDAMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:12:44 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:50447 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261998AbTFDAM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:12:27 -0400
Date: Wed, 4 Jun 2003 10:24:14 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: davidm@hpl.hp.com
cc: Martin Josefsson <gandalf@wlug.westbo.se>, <kuznet@ms2.inr.ac.ru>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@linuxia64.org>,
       <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: fix TCP roundtrip time update code
In-Reply-To: <16092.60612.352739.581639@napali.hpl.hp.com>
Message-ID: <Mutt.LNX.4.44.0306041021450.28035-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, David Mosberger wrote:

>   Martin> I tested this patch and it looks like it has cured my
>   Martin> mysterious TCP stalls.
> 
> Yes, this sounds reasonable.  I wasn't very clear on this point, but
> "by going south" I meant that TCP is starting to misbehave.  In
> particular, you'll likely end up with the kernel aborting ESTABLISHED
> TCP connections with extreme prejudice (and in violation of the TCP
> protocol), because it thought that it had been unable to communicate
> with the remote end for a _very_ long time.  The net effect typically
> is that you end up with one end having a connection that's in the
> ESTABLISHED state and the other end having no trace of that
> connection.

David,

This might be the solution to one of the 'must-fix' bugs for the
networking, which nobody so far was quite able to track down.


- James
-- 
James Morris
<jmorris@intercode.com.au>


