Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUF3Euq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUF3Euq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUF3Es7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:48:59 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:50654
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266465AbUF3Ese (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:48:34 -0400
Message-ID: <40E24573.5030403@redhat.com>
Date: Tue, 29 Jun 2004 21:45:39 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
References: <40E0EAC1.50101@redhat.com>	<20040629012604.20c3ad8b.davem@redhat.com>	<40E1BE7D.7070806@redhat.com> <20040629141915.0268b741.davem@redhat.com>
In-Reply-To: <20040629141915.0268b741.davem@redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Ulrich, is there a major reason why you can't use RTNETLINK for
> your implementation?  It behaves as you desire and gives you
> all of the link information you are after, in place of SIOCGIFCONF.

When was the netlink interface introduced?  The ioctl() code is most
probably older and therefore we would still get wrong results on old
kernels.  I don't know the reason why  you hesitate, but the patch seems
really harmless and, as you pointed out, more compatible with the BSD
version.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
