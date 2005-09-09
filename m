Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVIIP1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVIIP1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVIIP1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:27:07 -0400
Received: from spirit.analogic.com ([208.224.221.4]:38157 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751414AbVIIP1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:27:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4321A40C.6080205@rulez.cz>
References: <4321A40C.6080205@rulez.cz>
X-OriginalArrivalTime: 09 Sep 2005 15:27:01.0900 (UTC) FILETIME=[ED0E24C0:01C5B552]
Content-class: urn:content-classes:message
Subject: Re: query_modules syscall gone? Any replacement?
Date: Fri, 9 Sep 2005 11:27:02 -0400
Message-ID: <Pine.LNX.4.61.0509091116490.4715@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: query_modules syscall gone? Any replacement?
Thread-Index: AcW1Uu00o0d6MPwqRxCDElun96+qIQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "iSteve" <isteve@rulez.cz>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Sep 2005, iSteve wrote:

> Greetings,
>  I'm coding an application that messes with modules a lot, and I've
> stumbled upon a query_modules syscall in my docs. Later I've found out
> that the docs come from modutils and that module-init-tools doesn't seem
> to document (any of) the syscalls.
>
>  May I then ask, why is the query_module syscall gone? And more
> importantly, what replaces it, if anything? It seems to me that parsing
> the /proc/modules is not only less comfortable, but according to the
> very obsolete manpage I have, it also can provide less information.
>
>  For exmaple I'm not aware of anything like QM_SYMBOLS on per-module
> basis like it was (do correct me if I am wrong, it'd simplify my work a
> lot), ... and getting QM_REFS for example requires extensive parsing of
> /proc/modules.
>
> Thanks in advance for reply.
>
>  - iSteve

The newer modutils package doesn't use query_modules and calling
that function will return -ENOSYS in 'modern' kernels. The
latest modutils becomes very sparse because most of the module
functionality got moved into the kernel where it expanded, err,..
don't get me started. Anyway, your user-mode interface is now
/proc/modules. It does provide a bit more information than
before, but as you noticed, it sucks^M^M^M^M^Mis not nice.
Have fun!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
