Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTJMOy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTJMOy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:54:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:60308 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261774AbTJMOyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:54:17 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16266.48213.389446.904941@gargle.gargle.HOWL>
Date: Mon, 13 Oct 2003 09:53:09 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: karim@opersys.com, jmorris@redhat.com, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
In-Reply-To: <20031011103429.5ebe3085.davem@redhat.com>
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
	<3F859DF1.8000602@opersys.com>
	<20031010005703.0daf3e19.davem@redhat.com>
	<3F86C519.4030209@opersys.com>
	<20031011103429.5ebe3085.davem@redhat.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
 > On Fri, 10 Oct 2003 10:41:29 -0400
 > Karim Yaghmour <karim@opersys.com> wrote:
 > 
 > > The question isn't whether netlink can transfer hundreds of thousands of
 > > data units in one fell swoop. The question is: is it more efficient than
 > > relayfs at this?
 > 
 > Wrong, it's the queueing model that's important for applications
 > like this.
 > 

relayfs isn't trying to provide a generic queueing model - it's
basically just an efficient buffering mechanism with hooks for
kernel-user data transfer.  It's a lower-level thing than netlink and
might even be of use to netlink as a buffering layer.

In any case, applications like tracing or kernel debugging don't have
a need for more of a queueing model than the in-order delivery and
event buffering capabilities relayfs provides, and since applications
like these either can't use netlink or would benefit from the
efficiency provided by a no-frills buffering scheme, maybe there
is actually a use for something like relayfs.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

