Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbULHV27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbULHV27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbULHV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:28:50 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53689
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261367AbULHV2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:28:40 -0500
Date: Wed, 8 Dec 2004 13:26:27 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: jbarnes@engr.sgi.com, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Message-Id: <20041208132627.1c73177e.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0412080952100.27324@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<20041202101029.7fe8b303.cliffw@osdl.org>
	<Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
	<200412080933.13396.jbarnes@engr.sgi.com>
	<Pine.LNX.4.58.0412080952100.27324@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004 09:56:00 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> A patch like this is important for applications that allocate and preset
> large amounts of memory on startup. It will drastically reduce the startup
> times.

I see.  Yet I noticed that while the patch makes system time decrease,
for some reason the wall time is increasing with the patch applied.
Why is that, or am I misreading your tables?
