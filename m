Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUIMLl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUIMLl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUIMLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:41:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:62777 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266543AbUIMLlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:41:24 -0400
Date: Mon, 13 Sep 2004 12:41:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: cmm@us.ibm.com, <dipankar@us.ibm.com>, <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Put size in array to get rid of barriers in
    grow_ary()
In-Reply-To: <20040911034025.GA8676@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0409131239490.17347-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Paul E. McKenney wrote:
> On Wed, Sep 08, 2004 at 03:07:53PM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 08, 2004 at 04:39:43PM +0100, Hugh Dickins wrote:
> > > Wouldn't it be a little nicer to start ipc_ids off pointing to a
> > > const ipc_id_ary of size 0, to avoid the various entries == NULL
> > > tests you had to add?
> > 
> > I like this one!!!  Will put a patch together.  Manfred's recent
> > patch applied a refcount, which negates the const part, but should
> > be no problem to put a size-zero structure in the struct ipc_ids.
> > (Having a separately allocated structure puts me back to checking
> > NULL pointers due to possibility of allocation failure.)
> 
> And here, finally, is the updated patch.  Still untested.

That looks good, Paul, thank you.  (But I too have not tested.)

Hugh

