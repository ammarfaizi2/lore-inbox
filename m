Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278216AbRJWUVc>; Tue, 23 Oct 2001 16:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278200AbRJWUVX>; Tue, 23 Oct 2001 16:21:23 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:48094 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S278216AbRJWUVP>; Tue, 23 Oct 2001 16:21:15 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <Pine.LNX.4.33L.0110231759020.3690-100000@imladris.surriel.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <ujkB7.3878$1%5.659642574@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003868506 000 192.168.192.240 (Tue, 23 Oct 2001 16:21:46 EDT)
NNTP-Posting-Date: Tue, 23 Oct 2001 16:21:46 EDT
Date: Tue, 23 Oct 2001 20:21:46 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L.0110231759020.3690-100000@imladris.surriel.com>,
Rik van Riel <riel@conectiva.com.br> wrote:
| On Tue, 23 Oct 2001, bill davidsen wrote:
| > In article <9r4c24$g2k$1@cesium.transmeta.com>,
| > H. Peter Anvin <hpa@zytor.com> wrote:
| >
| > | The right thing is to get rid of the old initrd compatibility cruft,
| > | but that's a 2.5 change.
| >
| >   Get rid of??? As long as you have some equivalent capability to get
| > the system up.
| 
| pivot_root(2) in combination with pivot_root(8)

I wasn't really asking about changing root after the system is up, the
part needed is the uncompressing of the filesystem into a ramdisk root f/s
or some such. After that it's pretty much open to any of several techniques.

Getting the modules loaded to support the root f/s and run a little rc
file to get things going is the bootstrap operation, and that's where
initrd is vital. You really don't want to build a kernel for every
machine if you have more than a few! One kernel and a few config and
initrd files is vastly easier.

What replaces the initial step?

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
