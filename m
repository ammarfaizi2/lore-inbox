Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTGNCu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270502AbTGNCu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:50:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46279 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270501AbTGNCu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:50:57 -0400
Date: Sun, 13 Jul 2003 19:56:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Set SOCK_DONE when TCP socket receives FIN
Message-Id: <20030713195606.0e913f8b.davem@redhat.com>
In-Reply-To: <20030714024100.GA23023@mail.jlokier.co.uk>
References: <20030714024100.GA23023@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 03:41:00 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> The SOCK_DONE flag is always clear and never set in 2.5.75.  Yet there
> is code which tests it, and if it's clear, will return -ENOTCONN.
> Admittedly I am confused as to how this is not noticed :)
> 
> This small patch sets it where it looks like it was intended.
> Please check.

Indeed, good catch.  This bug got introduced when we changed
all of those volatile char things into a flags bitmask
(ChangeSet 1.889.291.25)

Patch applied, thanks.
