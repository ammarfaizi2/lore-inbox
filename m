Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267068AbUBRXri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267074AbUBRXri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:47:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57745 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267068AbUBRXrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:47:35 -0500
Date: Wed, 18 Feb 2004 18:47:33 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: Re: [SELINUX] Event notifications via Netlink
In-Reply-To: <20040218144346.B22989@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0402181845520.29323-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Chris Wright wrote:

> * James Morris (jmorris@redhat.com) wrote:
> > +static int selnl_msglen(int msgtype)
> > +	default:
> > +		BUG();
> > +static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *data)
> > +	default:
> > +		BUG();
> 
> Is BUG() the best error here, or too draconian?
> 

Reaching this would be incorrect use of a kernel API, leading to 
malfunctioning security code, so I feel that a BUG() is appropriate.


- James
-- 
James Morris
<jmorris@redhat.com>


