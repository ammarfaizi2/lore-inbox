Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVCHWZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVCHWZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVCHWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:25:29 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:16002 "HELO
	develer.com") by vger.kernel.org with SMTP id S261578AbVCHWZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:25:16 -0500
Message-ID: <422E2643.4010004@develer.com>
Date: Tue, 08 Mar 2005 23:25:07 +0100
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Saaby <as@cohaesio.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>,
       Neil Conway <nconway_kernel@yahoo.co.uk>, nfs@lists.sourceforge.net
Subject: Re: NFS client bug in 2.6.8-2.6.11
References: <422D2FDE.2090104@develer.com> <422D485F.5060709@develer.com> <422D4E5A.1050409@develer.com> <200503080956.41086.as@cohaesio.com>
In-Reply-To: <200503080956.41086.as@cohaesio.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Saaby wrote:
> On Tuesday 08 March 2005 08:03, Bernardo Innocenti wrote:
> 
>>Bernardo Innocenti wrote:
>>
>>>Trond Myklebust wrote:
>>>
>>>I also can't reproduce the problem on an older
>>>client running 2.4.21.
>>
>>Well, actually I tried harder with the 2.4.21
>>client and I obtained a similar effect:
>>
>>So, instead of ENOENT I get ESTALE on 2.4.21.
>>
>>May well be a server bug then.  The server is running
>>2.6.10-1.766_FC3.  Do you think I should try installing
>>a vanilla kernel on the server?
> 
> 
> We have seen lots of ESTALE's/ENOENT's when the server is running 2.6.10 
> (vanilla). Don't know if this was supposed to be fixed in the 2.6.10-FC 
> kernels, but vanilla 2.6.11 doesen't seem to have this bug at all.
> 
> You mention a lot of kernel versions including 2.6.11, and I can't really 
> figure out whether you are talking abount the clients or the server. - 
> Anyways if your server has only run with 2.6.10 - try 2.6.11.

Thank you, I've finally nailed it down by upgrading the
*server* kernel from 2.6.10-1.770_FC3 to 2.6.10-1.770_FC3.

The latter is basically 2.6.10-ac12 plus a bunch of vendor
specific patches.


> - Apologies if I missed something obvious.

No, *I* did.  All the clues I had leaded me to the client
side, while the problem was in the server instead.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

