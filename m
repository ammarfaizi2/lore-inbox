Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFFJm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFFJm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFFJm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:42:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16308 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261262AbVFFJmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:42:14 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050603200339.GA2445@halcrow.us> 
References: <20050603200339.GA2445@halcrow.us>  <20050602054852.GB4514@sshock.rn.byu.edu> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] eCryptfs: export key type 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Mon, 06 Jun 2005 10:42:02 +0100
Message-ID: <16336.1118050922@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> > +EXPORT_SYMBOL( key_type_user );
> 
> This is the only modification necessary to support eCryptfs.

Unfortunately, that might have to be EXPORT_SYMBOL_GPL() nowadays since I
reimplemented the predefined keyring types of user and keyring using RCU.

> While we are working on getting it ready for merging into the mainline
> kernel, we would like to distribute it as a separate kernel module, and we
> would like for users or distro's do not need to modify their kernels to
> build and run it.

"It" being?

> Would there be any objections to exporting the key_type_user symbol?
> Is there any general reason why kernel modules should not have access
> to the user key type struct?

No and no, but see above. You could also export the user defined key type ops
and define your own key type using them.

David
