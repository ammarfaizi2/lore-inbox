Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbULEAeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbULEAeg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULEAeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:34:36 -0500
Received: from smtp-out4.iol.cz ([194.228.2.92]:42971 "EHLO smtp-out4.iol.cz")
	by vger.kernel.org with ESMTP id S261208AbULEAef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:34:35 -0500
Message-ID: <41B25798.3080600@stud.feec.vutbr.cz>
Date: Sun, 05 Dec 2004 01:34:32 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Alessandro Amici <alexamici@fastwebnet.it>,
       Miguel Angel Flores <maf@sombragris.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel development environment
References: <41B1F97A.80803@sombragris.com>	 <200412042121.49274.alexamici@fastwebnet.it>	 <41B22381.10008@sombragris.com>	 <200412042237.48729.alexamici@fastwebnet.it>	 <1102196829.28776.46.camel@krustophenia.net>	 <41B22EDE.2060009@stud.feec.vutbr.cz>	 <1102200355.28776.58.camel@krustophenia.net>  <41B24A46.2010802@osdl.org> <1102204514.28776.79.camel@krustophenia.net>
In-Reply-To: <1102204514.28776.79.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> diff foo bar | xclip works perfectly with my mailer and does not
> require a temporary file.

Pasting from xclip to Mozilla Thunderbird works for me IFF the selection 
is 4096 bytes or less. But it looks like a bug in xclip, not Mozilla. 
Try this:

$ (for i in `seq 1 4096`; do echo -n 'a'; done) | xclip
$ xclip -o
aaaaaaaaaaaa......aaa

$ (for i in `seq 1 4097`; do echo -n 'a'; done) | xclip
$ xclip -o
[hangs]

This is with SuSE 8.2 and xclip from a Debian package 
xclip_0.08-4_i386.deb .

> There is no good reason for this not to work in mozilla.
 > Therefore it's a bug.

Not a Mozilla bug.

Michal
