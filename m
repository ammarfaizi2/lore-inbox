Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbULEV3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbULEV3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULEV3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:29:31 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:38469
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261401AbULEV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:29:20 -0500
Message-ID: <41B37DA1.2010607@ev-en.org>
Date: Sun, 05 Dec 2004 21:29:05 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Alessandro Amici <alexamici@fastwebnet.it>,
       Miguel Angel Flores <maf@sombragris.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel development environment
References: <41B1F97A.80803@sombragris.com>	 <200412042121.49274.alexamici@fastwebnet.it>	 <41B22381.10008@sombragris.com>	 <200412042237.48729.alexamici@fastwebnet.it>	 <1102196829.28776.46.camel@krustophenia.net>	 <41B22EDE.2060009@stud.feec.vutbr.cz>	 <1102200355.28776.58.camel@krustophenia.net>  <41B24A46.2010802@osdl.org> <1102204514.28776.79.camel@krustophenia.net> <41B25798.3080600@stud.feec.vutbr.cz>
In-Reply-To: <41B25798.3080600@stud.feec.vutbr.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:
> Lee Revell wrote:
> 
>> diff foo bar | xclip works perfectly with my mailer and does not
>> require a temporary file.
> 
> 
> Pasting from xclip to Mozilla Thunderbird works for me IFF the selection 
> is 4096 bytes or less. But it looks like a bug in xclip, not Mozilla. 
> Try this:
> 
> $ (for i in `seq 1 4096`; do echo -n 'a'; done) | xclip
> $ xclip -o
> aaaaaaaaaaaa......aaa
> 
> $ (for i in `seq 1 4097`; do echo -n 'a'; done) | xclip
> $ xclip -o
> [hangs]
> 
> This is with SuSE 8.2 and xclip from a Debian package 
> xclip_0.08-4_i386.deb .

I've done some work on xclip in Debian so I thought to test it. It 
doesn't happen to me on my Debian testing with xclip 0.08-4

After 4k of transfers the clipboard protocol means sending multiple 
messages, I've did some fixes in that area a while ago and didn't hear 
of any problems in that area.

I'd be happy to hear of such problems, directly or in the Debian BTS.

Baruch
