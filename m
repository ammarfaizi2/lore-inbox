Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbTGOSeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269412AbTGOSeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:34:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57287
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269400AbTGOSdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:33:49 -0400
Subject: Re: [patch] vesafb fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20030715182253.GG15505@suse.de>
References: <20030715141023.GA14133@bytesex.org>
	 <20030715173557.GB1491@mail.jlokier.co.uk> <20030715175358.GB15505@suse.de>
	 <1058292400.3845.59.camel@dhcp22.swansea.linux.org.uk>
	 <20030715182253.GG15505@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058294762.3857.63.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 19:46:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 19:22, Dave Jones wrote:
> I can't see how you can cover an not-a-powerof2 size area of memory
> without doing too little/too much. The winchip code was written with
> RAM in mind, which is always a power of 2 unless you boot with
> mem=fooMB

RAM is never power of two, a few bits always vanish off the ends.
The trick is that you start at a power of 2 boundary then build up/down
if you have to do power of two ranges

