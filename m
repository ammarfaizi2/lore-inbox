Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbULOKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbULOKwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbULOKwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:52:17 -0500
Received: from twin.jikos.cz ([213.151.79.26]:61151 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S262321AbULOKwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:52:12 -0500
Date: Wed, 15 Dec 2004 11:52:08 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: ramos_fabiano@yahoo.com.br
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: help with access_process_vm
In-Reply-To: <5afb2c65041214125270170a1@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412151149330.26342@twin.jikos.cz>
References: <5afb2c65041214112577ff4a18@mail.gmail.com> 
 <20041214123124.R469@build.pdx.osdl.net> <5afb2c65041214125270170a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Fabiano Ramos wrote:

> Is it possible to put the process that caused the trap to sleep, call
> schedule and defer this access_process_vm to later on with irqs enabled
> and only than resume the faulty process?

How would you ever reschedule that? There is no way scheduler can schedule 
interrupt contexts.

Try thinking about using some bottom half mechanisms which is kernel 
providing. Also consider this as offtopic here, should go to linux kernel 
newbies malinglist.

Cheers,

-- 
JiKos.
