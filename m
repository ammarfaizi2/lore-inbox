Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVGUXWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVGUXWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 19:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGUXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 19:22:41 -0400
Received: from gate.in-addr.de ([212.8.193.158]:61839 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261920AbVGUXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 19:22:40 -0400
Date: Fri, 22 Jul 2005 01:22:35 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux clustering <linux-cluster@redhat.com>,
       "Walker, Bruce J (HP-Labs)" <bruce.walker@hp.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, clusters_sig@lists.osdl.org
Subject: Re: [Clusters_sig] RE: [Linux-cluster] Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050721232235.GJ24464@marowsky-bree.de>
References: <3689AF909D816446BA505D21F1461AE404167CFB@cacexc04.americas.cpqcorp.net> <20050720180918.GU5416@marowsky-bree.de> <20050720183938.GM16618@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050720183938.GM16618@ca-server1.us.oracle.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-07-20T11:39:38, Joel Becker <Joel.Becker@oracle.com> wrote:

> 	In turn, let me clarify a little where configfs fits in to
> things.  Configfs is merely a convenient and transparent method to
> communicate configuration to kernel objects.  It's not a place for
> uevents, for netlink sockets, or for fancy communication.  It allows
> userspace to create an in-kernel object and set/get values on that
> object.  It also allows userspace and kernelspace to share the same
> representation of that object and its values.
> 	For more complex interaction, sysfs and procfs are often more
> appropriate.  While you might "configure" all known nodes in configfs,
> the node up/down state might live in sysfs.  A netlink socket for
> up/down events might live in procfs.  And so on.

Right. Thanks for the clarification and elaboration, for I am sure
not entirely clear as to how all these mechanisms relate in detail and
what is appropriate just where, and when to use something more classic
like ioctl etc... ;-)

FWIW, we didn't mean to get uevents out via configfs of course.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

