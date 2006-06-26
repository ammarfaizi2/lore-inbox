Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932973AbWFZTjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbWFZTjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932977AbWFZTjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:39:12 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:23821 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S932971AbWFZTjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:39:10 -0400
Message-ID: <20060626233909.A4686@castle.nmd.msu.ru>
Date: Mon, 26 Jun 2006 23:39:09 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com> <20060626194625.E989@castle.nmd.msu.ru> <44A003CD.9050204@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44A003CD.9050204@fr.ibm.com>; from "Daniel Lezcano" on Mon, Jun 26, 2006 at 05:57:01PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 05:57:01PM +0200, Daniel Lezcano wrote:
> Andrey Savochkin wrote:
> > On Mon, Jun 26, 2006 at 04:56:46PM +0200, Daniel Lezcano wrote:
> >>
> >>How do you handle ICMP_REDIRECT ?
> > 
> > 
> > Are you talking about routing cache entries created on incoming redirects?
> > Or outgoing redirects?
> > 
> 
> incoming redirects

They are inserted into routing cache with the current namespace tag, in
the same way as input routing cache entries.

	Andrey
