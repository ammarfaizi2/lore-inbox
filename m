Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbUKVLGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUKVLGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUKVLFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:05:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21484 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262060AbUKVLD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:03:57 -0500
Date: Mon, 22 Nov 2004 12:03:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: var args in kernel?
In-Reply-To: <20041122102933.GG29305@bytesex>
Message-ID: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de>
 <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de>
 <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de>
 <20041118165853.GA22216@bytesex> <419E689A.5000704@backtobasicsmgmt.com>
 <20041122094312.GC29305@bytesex> <20041122101646.GP10340@devserv.devel.redhat.com>
 <20041122102933.GG29305@bytesex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  What you can't do is e.g.
>>   va_list ap;
>>   va_start (ap, x);
>>   bar (x, ap);
>>   bar (x, ap);
>>   va_end (ap);

In theory, you can't. But the way how GCC (and probably other compilers)
implement it, you can. Because "ap" is just a pointer (which fits into a
register, if I may add). As such, you can copy it, pass it multiple times, use
it multiple times, and whatever you like.

At least that's IIRC the way TCPP recommends you in their helpfile
(va_list src; ... va_list dest = src)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
