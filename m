Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbUDGUBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUDGUBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:01:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:65427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264188AbUDGUBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:01:06 -0400
Date: Wed, 7 Apr 2004 13:03:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-Id: <20040407130308.7c7ec8dc.akpm@osdl.org>
In-Reply-To: <20040407194727.GE2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org>
	<20040406173326.0fbb9d7a.akpm@osdl.org>
	<20040407173116.GB2814@hexapodia.org>
	<20040407111841.78ae0021.akpm@osdl.org>
	<20040407192432.GD2814@hexapodia.org>
	<20040407123455.0de9ffa9.akpm@osdl.org>
	<20040407194727.GE2814@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> I claim that O_DIRECT on of= is important because you just plain *can
> not* do the minimal-sized IDE block scrub without it.  I don't yet see a
> similar benefit to O_DIRECT on if= side.

If you want a block scrubber then write a block scrubber.

If you want to add O_DIRECT support to dd then it should be implemented
properly, and that means implementing it for both read and write.

In fact the user should be able to specify the read-O_DIRECT and the
write-O_DIRECT independently - if for no other reason than that the source
and dest filesytems may not both support O_DIRECT.
