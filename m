Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbUDGAb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 20:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUDGAb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 20:31:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:64937 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264084AbUDGAbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 20:31:16 -0400
Date: Tue, 6 Apr 2004 17:33:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-Id: <20040406173326.0fbb9d7a.akpm@osdl.org>
In-Reply-To: <20040406220358.GE4828@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> On modern Linux, apparently the correct way to bypass the buffer cache
> when writing to a block device is to open the block device with
> O_DIRECT.  This enables, for example, the user to more easily force a
> reallocation of a single sector of an IDE disk with a media error
> (without overwriting anything but the 1k "sector pair" containing the
> error).  dd(1) is convenient for this purpose, but is lacking a method
> to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> enable this usage.

This would be rather nice to have.  You'll need to ensure that the data
is page-aligned in memory.

While you're there, please add an fsync-before-closing option.
