Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVGLOWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVGLOWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVGLOWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:22:31 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:8632
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261457AbVGLOVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:21:46 -0400
Message-ID: <42D3D1F3.1030405@ev-en.org>
Date: Tue, 12 Jul 2005 15:21:39 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?VG9tYXN6IEvFgm9jemtv?= <kloczek@rudy.mif.pg.gda.pl>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Kłoczko wrote:
> On Mon, 11 Jul 2005, Tom Zanussi wrote:
> 
>>
>> Hi Andrew, can you please merge relayfs?  It provides a low-overhead
>> logging and buffering capability, which does not currently exist in
>> the kernel.
>>
>> relayfs key features:
>>
>> - Extremely efficient high-speed logging/buffering
> 
> 
> Usualy/for now relayfs is used as base infrastructure for variuos
> debuging/measuring.
> IMO storing raw data and transfer them to user space it is wrong way.
> Why ? Becase i adds very big overhead for memory nad storage.
> Big .. compare to in situ storing partialy analyzed data in conters
> and other like it is in DTrace.
> 
> IMO much better will be add base/template set of functions for use in
> KProbes probes which will come with KProbes code as base tool set. It
> will allow cut transfered data size from megabites/gigabyutes to hundret
> bytes/kilo bytes, make debuging/measuring more smooth without additional
> latency for transfer data outside kernel space.

There is no relation between using kprobes and reducing the logged data
size. At the end the debugging/tracing facility is there to provide data
to the developer who tries to detect the problem or ensure correctness.

The kprobes can only serve as a replacement to changing the source code
in order to extract the debugging information, and it does it very well.

Cutting the amount of data transferred is only possible if you add the
problem detection logic into the kernel and only transport problem
reports to user-mode.

Baruch
