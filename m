Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTEPSdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTEPSdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:33:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264553AbTEPSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:33:42 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] submount: another removeable media handler
Date: 16 May 2003 11:46:20 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ba3bls$c2p$1@cesium.transmeta.com>
References: <200305160106.37274.eweiss@sbcglobal.net> <20030516113304.GK32559@Synopsys.COM> <200305161027.20045.eweiss@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200305161027.20045.eweiss@sbcglobal.net>
By author:    Eugene Weiss <eweiss@sbcglobal.net>
In newsgroup: linux.dev.kernel
>
> 
> > how is it different from what automounter does?
> 
> Autofs works by creating a special filesystem above the vfs layer, and passing 
> requests and data back and forth.   Submount actually does much less than 
> this- it puts a special filesystem underneath the real one, and the only 
> things it returns to the VFS layer are error messages.  It handles no IO 
> operations whatsoever.
> 
> Peter Anvin has called using the automounter for removeable media "abuse."
> Submount is designed for it.
> 

Sure, but it's not clear to me that you have listened to me saying
*why* it is abuse.

Basically, in my opinion removable media should be handled by insert
and removal detection, not by access detection.  Obviously, there are
some sticky issues with that in the case where media can be removed
without notice (like PC floppies or other manual-eject devices), but
overall I think that is the correct approach.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
