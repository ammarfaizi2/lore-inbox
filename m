Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUIOWkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUIOWkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUIOWkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:40:01 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54467 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267690AbUIOWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:39:35 -0400
Subject: Re: [PATCH] hvc_console fix to protect hvc_write against ldisc
	write after hvc_close
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ryan Arnold <rsa@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915204107.GA26776@thunk.org>
References: <1095273835.3294.278.camel@localhost>
	 <20040915204107.GA26776@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095284172.20754.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 22:36:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 21:41, Theodore Ts'o wrote:
> The current (I can't speak to what Alan Cox is going to change) rules
> with tty drivers is that tty drivers are supposed to close the line
> discpline in their close routines. 

That has no actual effect in the real world because the ldisc can in
part be running on another processor at the same time in another
function.  This is a crash case seen on 2.4 in the real world.

Alan

