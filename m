Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWEVOOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWEVOOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWEVOOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:14:45 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:21711 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750841AbWEVOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:14:44 -0400
Subject: Re: [PATCH] Add user taint flag
From: Arjan van de Ven <arjan@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
Content-Type: text/plain
Date: Mon, 22 May 2006 16:14:36 +0200
Message-Id: <1148307276.3902.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 19:04 -0400, Theodore Ts'o wrote:
> Allow taint flags to be set from userspace by writing to
> /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> used when userspace is potentially doing something naughty that might
> compromise the kernel. 

we should then patch the /dev/mem driver or something to set this :)
(well and possibly give it an exception for now for PCI space until the
X people fix their stuff to use the proper sysfs stuff)

