Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTDXWas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDXWas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:30:48 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:14340 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S264174AbTDXWaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:30:46 -0400
Date: Fri, 25 Apr 2003 00:43:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: sp@osb.hu
Subject: Re: [PATCH 2.4] dmi_ident made public
Message-Id: <20030425004302.058bcc40.khali@linux-fr.org>
In-Reply-To: <1051209098.4005.4.camel@dhcp22.swansea.linux.org.uk>
References: <20030424184759.5f7b3323.khali@linux-fr.org>
	<1051209098.4005.4.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Here is a simple patch for the 2.4 kernel series that makes
> > dmi_ident (as defined in arch/i386/kernel/dmi_scan.c) public.
> 
> The dmi scanner is __init, its gone after boot. The DMI tables on some
> platforms may also have gone. What you actually want I suspect is a
> way to register multiple DMI tables for boot time scanning to set
> further flags in the dmi properties post scan.

I never intended to call any function in dmi_scan from outside. I know
this stuff is __init, and what would be the point in rescanning the same
table again anyway? No, what I want is to make dmi_ident, which is the
array containing the results of the dmi scan, to be available to
everyone. Take a look at the previously sent patch, I think it's quite
straightforward.

I'm not sure I understand well what you mean with "register multible DMI
tables", so it's probably not what I want ;)

Let me know if I really missed something.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
