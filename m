Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUAOTyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUAOTyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:54:35 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:44223 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261879AbUAOTyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:54:31 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m17jztau8l.fsf@ebiederm.dsl.xmission.com>
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave>
	<m1smihg56u.fsf@ebiederm.dsl.xmission.com>
	<1074185897.1868.118.camel@mulgrave> 
	<m17jztau8l.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Jan 2004 14:54:19 -0500
Message-Id: <1074196460.1868.250.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 14:26, Eric W. Biederman wrote:
> And end up looking like:
> fec00000-fec00fff : reserved
> fec01000-fec013ff : 0000:00:0f.0
> fec01400-fec08fff : reserved

Oh, I see you're splitting an existing resource around it.

So the e820 map requests reserved regions with tentative and
insert_resource is allowed to place resources into tentative regions. 
That works for me, but I don't see how it works for the bridge
case...there you really want to insert the bridge resource over
everything else.

James


