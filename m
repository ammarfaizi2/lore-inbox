Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbUDNAD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUDNAD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:03:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:41119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263814AbUDNAD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:03:27 -0400
Date: Tue, 13 Apr 2004 17:03:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
Message-Id: <20040413170309.14b7a334.akpm@osdl.org>
In-Reply-To: <1081881778.5585.16.camel@bluerhyme.real3>
References: <1081881778.5585.16.camel@bluerhyme.real3>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Frederick <Fabian.Frederick@skynet.be> wrote:
>
> 
>  	I'm trying to remove the race in sys_access code.
>  AFAICS, fsuid is checked in "permission" level so I pushed real fsuid
>  capture forward.

Do races in access() actually matter?  I mean, some other process could
change things a nanosecond after access() has completed and the value which
the access() caller received is wrong anyway.

Or is there some deeper problem which you are addressing here?
