Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUHDJor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUHDJor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUHDJor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:44:47 -0400
Received: from mail1.kontent.de ([81.88.34.36]:45548 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263040AbUHDJop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:44:45 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Liu Tao <liutao@safe-mail.net>
Subject: Re: [patch] Add a writer prior lock methord for rwlock
Date: Wed, 4 Aug 2004 11:45:06 +0200
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <4110A7AF.2060903@safe-mail.net>
In-Reply-To: <4110A7AF.2060903@safe-mail.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041145.07452.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. August 2004 11:09 schrieb Liu Tao:
> The patch adds the write_forcelock() methord, which has higher priority than
> read_lock() and write_lock(). The original read_lock() and write_lock() 
> is not
> touched, and the unlock methord is still write_unlock();

It seems to me that with this a recursive read_lock() with
a read lock already held may deadlock.

	Regards
		Oliver
