Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTEDTza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTEDTza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:55:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261568AbTEDTz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:55:29 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Date: 4 May 2003 13:07:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b93ru9$oua$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0305030249280.30960-100000@devserv.devel.redhat.com> <Pine.LNX.4.33L2.0305040243390.2890-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33L2.0305040243390.2890-100000@rtlab.med.cornell.edu>
By author:    "Calin A. Culianu" <calin@ajvar.org>
In newsgroup: linux.dev.kernel
> 
> Clearly this address is less than 16MB, so then it must be possible to
> jump to memory below 16MB.
> 

There is another issue: x86 uses relative jumps, so although "ASCII
armor" addresses aren't easily accessible using return address smashes
(although the \0 at the end thing is a real issue), you may be able to
get to them through a jump instruction.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
