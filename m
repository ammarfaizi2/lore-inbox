Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUL3MG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUL3MG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 07:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUL3MG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 07:06:58 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:55476 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S261609AbUL3MG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 07:06:57 -0500
From: Mike Hearn <mh@codeweavers.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Sailer <sailer@scs.ch>, Jesse Allen <the3dfxdude@gmail.com>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <1104348944.5645.2.camel@kronenbourg.scs.ch>
	 <5304685704122912132e3f7f76@mail.gmail.com>
	 <1104371395.5128.2.camel@gamecube.scs.ch>
	 <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
Organization: Codeweavers, Inc
Date: Thu, 30 Dec 2004 12:11:57 +0000
Message-Id: <1104408717.3073.1.camel@littlegreen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-SPF-Flag: YES
X-SA-Exim-Connect-IP: 81.97.76.53
X-SA-Exim-Mail-From: mh@codeweavers.com
Subject: Re: ptrace single-stepping change breaks Wine
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 18:10 -0800, Linus Torvalds wrote:
> Some wine person would need to inform us about what the seh exception 
> thing means.. "code c0000005"? 

STATUS_ACCESS_VIOLATION, or the Win32 equivalent of a segfault. It would
appear that the ptrace changes are not responsible here, though if
changing the kernel really does change this crash then maybe there is
another issue we haven't uncovered yet.

thanks -mike

