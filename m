Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWH2Qot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWH2Qot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWH2Qot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:44:49 -0400
Received: from gw.goop.org ([64.81.55.164]:1672 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965103AbWH2Qos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:44:48 -0400
Message-ID: <44F46EF9.2090000@goop.org>
Date: Tue, 29 Aug 2006 09:44:41 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, Andi Kleen <ak@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>  <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>  <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com> <1156867503.2722.72.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0608291828540.8682@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608291828540.8682@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Since it's all just virtual addresses, is the TLB flush really that much 
> different when kernelspace runs from (virtual) 0x00000000-0x3FFFFFFF rather 
> than (virtual)0xC000000-0xFFFFFFFF?
>   

If kernel and userspace are disjoint, they can be in the same address 
space, so there's no need for a TLB flush at all.

    J
