Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVCHHHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVCHHHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVCHHG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:06:26 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:63192 "HELO
	develer.com") by vger.kernel.org with SMTP id S261787AbVCHHDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:03:53 -0500
Message-ID: <422D4E5A.1050409@develer.com>
Date: Tue, 08 Mar 2005 08:03:54 +0100
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>,
       Neil Conway <nconway_kernel@yahoo.co.uk>, nfs@lists.sourceforge.net
Subject: Re: NFS client bug in 2.6.8-2.6.11
References: <422D2FDE.2090104@develer.com> <1110259831.11712.1.camel@lade.trondhjem.org> <422D485F.5060709@develer.com>
In-Reply-To: <422D485F.5060709@develer.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> Trond Myklebust wrote:
>
> I also can't reproduce the problem on an older
> client running 2.4.21.

Well, actually I tried harder with the 2.4.21
client and I obtained a similar effect:

 naraku:/pub/linux/distro/fedora-devel# ll
 ls: .: Stale NFS file handle
 naraku:/pub/linux/distro/fedora-devel# cd -
 /arc/linux
 naraku:/arc/linux# cd -
 /pub/linux/distro/fedora-devel
 naraku:/pub/linux/distro/fedora-devel# ll
 ... (lots of files)


So, instead of ENOENT I get ESTALE on 2.4.21.

May well be a server bug then.  The server is running
2.6.10-1.766_FC3.  Do you think I should try installing
a vanilla kernel on the server?

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

