Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTDNOxI (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTDNOxI (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:53:08 -0400
Received: from franka.aracnet.com ([216.99.193.44]:27116 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263415AbTDNOxF (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 10:53:05 -0400
Date: Mon, 14 Apr 2003 08:04:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Antonio Vargas <wind@cocodriloo.com>
cc: Bryan Shumsky <bzs@via.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
Message-ID: <11640000.1050332688@[10.10.2.4]>
In-Reply-To: <20030414150759.GA14552@wind.cocodriloo.com>
References: <002101c30239$fc0ae630$fe64a8c0@webserver> <8180000.1050330998@[10.10.2.4]> <20030414150759.GA14552@wind.cocodriloo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin, something which was not mentioned last week (I've just checked).
> 
> It's OK if we never write to disk unless explicitely told, but will we writeback
> when we munmap?

Don't know for sure - you'd have to read the code (do_munmap) ... I couldn't
see anything there at a quick glance. However, I'd guess we don't write it, 
as multiple people could have the file mapped, or we could remap it
again from somewhere. Presumably the standard LRU will just flush it out.

M.

