Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVFXUbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVFXUbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFXUbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:31:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262423AbVFXUan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:30:43 -0400
Date: Fri, 24 Jun 2005 13:28:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [-mm patch] i386: enable REGPARM by default
Message-Id: <20050624132826.4cdfb63c.akpm@osdl.org>
In-Reply-To: <20050624200916.GJ6656@stusta.de>
References: <20050624200916.GJ6656@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch:
> - removes the dependency of REGPARM on EXPERIMENTAL
> - let REGPARM default to y

hm, a compromise.

One other concern I have with this is that I expect -mregparm will make
kgdb (and now crashdump) less useful.  When incoming args are on the stack
you have a good chance of being able to see what their value is by walking
the stack slots.

When the incoming args are in registers I'd expect that it would be a lot
harder (or impossible) to work out their value.

Have the kdump guys thought about (or encountered) this?

