Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWEPLY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWEPLY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWEPLY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:24:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32429 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751784AbWEPLY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:24:28 -0400
Date: Tue, 16 May 2006 13:24:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Con Kolivas <kernel@kolivas.org>
cc: linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: cleanup swap unused warning
In-Reply-To: <200605102132.41217.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.64.0605161322110.17704@scrub.home>
References: <200605102132.41217.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-1682810690-1147778662=:17704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-1682810690-1147778662=:17704
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 10 May 2006, Con Kolivas wrote:

> Are there any users of swp_entry_t when CONFIG_SWAP is not defined?
>=20
> This patch fixes a warning for !CONFIG_SWAP for me.
>=20
> ---
> if CONFIG_SWAP is not defined we get:
>=20
> mm/vmscan.c: In function =E2=80=98remove_mapping=E2=80=99:
> mm/vmscan.c:387: warning: unused variable =E2=80=98swap=E2=80=99

In similiar cases (e.g. spinlocks) we usually do something like this:

#define swap_free(swp)=09((void)(swp))

bye, Roman
---1463811837-1682810690-1147778662=:17704--
