Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVA0KsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVA0KsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVA0KmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:42:19 -0500
Received: from one.firstfloor.org ([213.235.205.2]:65503 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262568AbVA0KgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:36:12 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch 1/6  introduce sysctl
References: <20050127101117.GA9760@infradead.org>
	<20050127101201.GB9760@infradead.org>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 Jan 2005 11:36:11 +0100
In-Reply-To: <20050127101201.GB9760@infradead.org> (Arjan van de Ven's
 message of "Thu, 27 Jan 2005 10:12:01 +0000")
Message-ID: <m1mzuv40ro.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> This first patch of the series introduces a sysctl (default off) that
> enables/disables the randomisation feature globally. Since randomisation may
> make it harder to debug really tricky situations (reproducability goes
> down), the sysadmin needs a way to disable it globally.

A global sysctl doesn't make much sense to me for this. If you
want to get some program running you don't want to impact your
system daemons. And a non root user couldn't enable it anyways,
which can be annoying if it is needed to get some binary working.

If anything I would make it a personality flag so that it can
be set per process.

-Andi
