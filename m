Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUGBQUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUGBQUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUGBQUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:20:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53656 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264697AbUGBQUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:20:33 -0400
Message-ID: <40E58AE9.6050009@austin.ibm.com>
Date: Fri, 02 Jul 2004 11:18:49 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
Reply-To: nfont@austin.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 0.7a (X11/20040614)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
CC: Paul Mackerras <paulus@samba.org>, linas@austin.ibm.com,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com> <20040701160614.I21634@forte.austin.ibm.com> <16613.15510.325099.273419@cargo.ozlabs.ibm.com> <3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com>
In-Reply-To: <3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I asked about this before, and was told that there is no way to
> determine the severity of an event without doing full parsing of the
> binary data. I'd be thrilled to be wrong...
> 

Gettting the severity of an RTAS event is possible, and not too 
difficult.  Check out asm-ppc64/rtas.h for a definition of the
RTAS event header (struct rtas_error_log).  All RTAS events have the 
same initial header containing the severity of the event.

Decoding RTAS events beyond the intial header, that gets ugly quick and 
will hopefully never need to be done in the kernel.

-- 
Nathan Fontenot

