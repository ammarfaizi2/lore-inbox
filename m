Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265798AbUF2QZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265798AbUF2QZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUF2QZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:25:13 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:61402
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265798AbUF2QZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:25:09 -0400
Message-ID: <40E19733.4000105@redhat.com>
Date: Tue, 29 Jun 2004 09:22:11 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
References: <40E0EAC1.50101@redhat.com> <20040629012604.20c3ad8b.davem@redhat.com>
In-Reply-To: <20040629012604.20c3ad8b.davem@redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> Anyways, I guess we could do your suggestion.  SIOCGIFCONF
> is actually implemented using per-protocol handlers.  So, for
> example there is an ipv4 handler, an ipv6 one, etc.  We'd need
> to make the change for all of them.

I might not look for the right thing, but there are only two places
where register_gifconf is used: in net/ipv4/devinet.c and
net/decnet/dn_dev.c.  There is no support for IPv6-only interfaces and
interfaces for other protocols.  So in addition to your change only the
DECnet stuff needs changing.


> I enclose a potential implementation for the ipv4 instance.
> Please at least make sure it does what you want.

I'll try the patch asap.  Thanks,

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
