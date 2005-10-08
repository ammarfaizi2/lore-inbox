Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbVJHAVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbVJHAVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVJHAVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:21:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161020AbVJHAVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:21:40 -0400
Date: Fri, 7 Oct 2005 17:21:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>, stefanr@s5r6.in-berlin.de,
       bcollins@debian.org, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 1/7] ieee1394/sbp2: fixes for hot-unplug and module unloading
Message-ID: <20051008002109.GM5856@shell0.pdx.osdl.net>
References: <20051007234348.631583000@press.kroah.org> <20051007235353.GA23111@kroah.com> <20051007235422.GB23111@kroah.com> <004ek192bmh6t6ei08cpnusf8dmpi0dk6d@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004ek192bmh6t6ei08cpnusf8dmpi0dk6d@4ax.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grant Coady (grant_lkml@dodo.com.au) wrote:
> On Fri, 7 Oct 2005 16:54:22 -0700, Greg KH <gregkh@suse.de> wrote:
> 
> >+static inline int sbp2util_node_is_available(struct scsi_id_instance_data *scsi_id)
> >+{
> >+	return scsi_id && scsi_id->ne && !scsi_id->ne->in_limbo;
> >+}
> >+
> > 
> ^^^^^ How did that 0x0c character sneak in there?

It's from the patched file (predating the patch, yes it should go, but
that's another story).

thanks,
-chris
