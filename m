Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUF2TNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUF2TNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUF2TNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:13:05 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:3548
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265959AbUF2TMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:12:54 -0400
Message-ID: <40E1BE7D.7070806@redhat.com>
Date: Tue, 29 Jun 2004 12:09:49 -0700
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

> I enclose a potential implementation for the ipv4 instance.
> Please at least make sure it does what you want.

Seems to work nicely.


> I really really hope there is not some application out there
> that assumes that devices reported by SIOCGIFCONF are all up.
> That works now, and we'd break things by making the suggested
> change.  So this is what I'm most concerned about.

The worst that could happen is that some more interfaces are reported.
Since the information provided by SIOCGIFCONF isn't really enough to do
anything meaningful other calls are needed at which point those
interfaces can be weeded out, if this is wanted.  Also, the address
family reported for those interfaces is AF_UNSPEC which should be a hint
strong enough to recognize them.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
