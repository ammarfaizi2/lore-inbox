Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUFVUYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUFVUYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFVUUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:20:14 -0400
Received: from holomorphy.com ([207.189.100.168]:21381 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265118AbUFVUQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:16:59 -0400
Date: Tue, 22 Jun 2004 13:16:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [profile]: [21/23] use atomic_t for prof_buffer
Message-ID: <20040622201654.GG2135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	rddunlap@osdl.org
References: <0406220817.4aXa3aHb5aMb4a3a1aYaZa3aIbXa5aIbKbJbXa1aLbJb4a2a2aZaYa0aHb2aMbYa15250@holomorphy.com> <0406220817.2aWaKb4aHb4aMbZaWaLbKb5aLbXaXa0aWaYa2a1aKb5aMb5aXaZa3aIbIbIbHbYa15250@holomorphy.com> <20040622130116.6e12a15a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622130116.6e12a15a.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 08:17:55 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Convert prof_buffer to an array of atomic_t's.

On Tue, Jun 22, 2004 at 01:01:16PM -0700, David S. Miller wrote:
> Part of a data type exported to userspace, is it not?
> Thus, is it really valid to change it like this?

They're copied raw to userspace now and casted to atomic_t for all
modifications except for sparc32, arm, h8300, m68k, and m68knommu,
where it's still equivalent (the atomic operations just do normal
arithmetic under hashed locks or with ll/sc or other easily zennable
asm), so there is no change. Or did I miss an arch?


-- wli
