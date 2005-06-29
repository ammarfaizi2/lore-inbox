Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVF2RuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVF2RuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVF2Rt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:49:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:18473 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262331AbVF2Rtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:49:46 -0400
Date: Wed, 29 Jun 2005 18:51:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ismail Donmez <ismail@kde.org.tr>
cc: randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc1 problems
In-Reply-To: <200506292015.11494.ismail@kde.org.tr>
Message-ID: <Pine.LNX.4.61.0506291842360.4262@goblin.wat.veritas.com>
References: <200506291934.32909.ismail@kde.org.tr>
 <Pine.LNX.4.61.0506291805090.3940@goblin.wat.veritas.com>
 <200506292015.11494.ismail@kde.org.tr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-478278002-1120067467=:4262"
X-OriginalArrivalTime: 29 Jun 2005 17:49:46.0081 (UTC) FILETIME=[EFF67510:01C57CD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-478278002-1120067467=:4262
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Jun 2005, Ismail Donmez wrote:
>=20
> Thank you both!.=C2=A0Any idea about this part? :
>=20
> Jun 29 19:16:32 localhost kernel: Badness in __kfree_skb at=20
> net/core/skbuff.c:290

I've not seen that one.  It's _possible_ that it's caused by the
same get_request bug: although that's over in a different subsystem,
it does mess up the preempt_count/hardirq_count enough to be able to
cause such a problem elsewhere.  But I see this message came 87 secs
after your others, which makes that unlikely.  Do you still see this
__kfree_skb badness after running with the get_request fix?

Hugh
--8323584-478278002-1120067467=:4262--
