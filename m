Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbVHPOZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVHPOZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 10:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbVHPOZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 10:25:48 -0400
Received: from [81.2.110.250] ([81.2.110.250]:23016 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965246AbVHPOZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 10:25:48 -0400
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kern Sibbald <kern@sibbald.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508161612.32406.kern@sibbald.com>
References: <200508161519.39719.kern@sibbald.com>
	 <1124200991.17555.33.camel@localhost.localdomain>
	 <200508161612.32406.kern@sibbald.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 15:52:48 +0100
Message-Id: <1124203968.17555.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 16:12 +0200, Kern Sibbald wrote:
> I verified that I have not explicitly set nonblocking on the socket, so expect 
> it to be default blocking. 

Depends where it came from and what OS. In particular the blocking state
of a socket returned from accept may be the same as the accepting
socket, or may be blocking depending on the exact system.

You could also try turning blocking on and seeing what effect that has

