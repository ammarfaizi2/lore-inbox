Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268296AbUHFUvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbUHFUvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268291AbUHFUvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:51:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56058 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268297AbUHFUqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:46:31 -0400
Message-ID: <4113EE1B.4030200@mvista.com>
Date: Fri, 06 Aug 2004 13:46:19 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <1091226922.5083.13.camel@localhost.localdomain> <410AEDC8.6030901@pobox.com> <410FCF9A.0@rtr.ca> <4113A839.40603@pobox.com> <4113DC15.8040102@am.sony.com>
In-Reply-To: <4113DC15.8040102@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of flogging this horse after the death certificate was just 
signed, there were two threads running through the discussion and I 
wasn't sure where things stand.  One thread, as I read it, was: "Don't 
hack around the delays, let's change the probing and do it right".  The 
other thread was: "Don't mess around with IDE probing, leave that alone 
and let's do it right for SATA".

If the latter route is how things are headed then I'd still suggest 
replacing the scattered hardcoded "50" constants with a meaningful symbol.

If, on the other hand, IDE probe delays might someday become more 
complicated, such that a single symbol is not sufficient (as Alan warned 
against), then at least it would be easier to find 'em all.  And 
converting some of the calls to use a new symbol for a new class of 
delays would be quite easy.

Anyhow, not a big deal; if there's anything I can help out with to 
improve the situation then I'd be glad to do so.

-- 
Todd Poynor
MontaVista Software

