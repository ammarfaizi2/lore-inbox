Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSEWP03>; Thu, 23 May 2002 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316760AbSEWP02>; Thu, 23 May 2002 11:26:28 -0400
Received: from air-2.osdl.org ([65.201.151.6]:35600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316756AbSEWP01>;
	Thu, 23 May 2002 11:26:27 -0400
Date: Thu, 23 May 2002 08:24:29 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Padraig Brady <padraig@antefacto.com>
cc: will fitzgerald <william.fitzgerald6@beer.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Question:kernel profiling and readprofile
In-Reply-To: <3CECF70C.1060208@antefacto.com>
Message-ID: <Pine.LNX.4.33L2.0205230819590.4119-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Padraig Brady wrote:

| will fitzgerald wrote:
| > hi all,
| >
| > i stumbled accross a command called readprofile by accident and found
| > that by appening the line append="profile=2" to the lilo.conf file
| > and using thread profile command you can get statistics on functions
| > that spend a certain amount of time doing a job.
| >
| > i done some searching on this and can't find anything other than a
| > man page on readprofile.
| >
| > can anyone tell me what does the line append="profile=2" actually do
| > apart from creating the file profile in the proc directory, what is
| > the 2 for in this line?
|
| The level. see linux/Documentation/kernel-parameters.txt
| Also worth looking at is http://oss.sgi.com/projects/kernprof/

or what readprofile calls the 'step' size, but the kernel parameter
is actually a shift value (1 << prof_shift), so it is the power-of-2
bucket size for each profiled bucket (all resident kernel code).
profile=2 means step (or bucket size) = 2^2 = 4 bytes per
profile counter.  Fairly fine-grained so it can pinpoint
code/functions fairly well.
profile=4 means step size of 2^4 = 16 bytes.  Uses less profile
buffer memory in the kernel.

| Also I don't think you can profile modules, but there was a patch...
| http://marc.theaimsgroup.com/?l=linux-kernel&m=101663078100596&w=2

Thanks for that link.  I'm interested in that.

-- 
~Randy

