Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSDXGaW>; Wed, 24 Apr 2002 02:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313927AbSDXGaV>; Wed, 24 Apr 2002 02:30:21 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:60170 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S293722AbSDXGaU>; Wed, 24 Apr 2002 02:30:20 -0400
Date: Wed, 24 Apr 2002 09:27:45 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Russ Fink <russfink@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: structure of ftp.kernel.org, patch dirs
Message-ID: <20020424092745.H22237@actcom.co.il>
In-Reply-To: <F43O6Nr85kNScMZ3lVR00008888@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 01:10:29PM -0400, Russ Fink wrote:
> Hello,
> 
> I'm a linux vet, but am relatively new to kernel compiling.  I'm trying to 
> trace a nasty bug, and I wish to build incremental kernels of the 2.2 tree. 
> I'm looking at ftp.kernel.org in the v2.2/testing directory, and have a 
> question about the directory setup.
> 
> Can someone tell me, what is the difference between patches in the "incr" 
> directory and patches in the "old" directory?
> 
> In pub/linux/kernel/v2.2/testing/incr/ I see files such as:
> patch-2.2.19-pre1-pre2.gz

That would be the patch that is the diff between 2.2.19-pre1 and
2.2.19-pre2. If you already have a tree with 2.2.19-pre1, you could
apply this patch and get a tree which is 2.2.19-pre2. 

> whereas in pub/linux/kernel/v2.2/testing/old/ I see:
> patch-2.2.19-pre2.gz

That would be a patch between 2.2.19 and 2.2.19-pre2. If you had a
pristine tree with 2.2.19, you would apply this one and get a tree
with 2.2.19-pre2. 

> My objective is to start with the latest 2.2.17 sources and patch it up to 
> specific levels, e.g., 2.2.18-pre3.  Do I use patches in "incr", or patches 
> in "old"?

If you want to go 17->18-prex directly, use the specific patch in
'old'. If you want to go through each pre in order, use those in
'incr'. 

> I'm guessing that "old" patches will take me from 2.2.17 to version
> 2.2.18-pre-"N" without needing to go through the previous N-1 patches first, 
> but that patches in "incr" will only take me from one patch level to the 
> next higher level (from 1 to 2, etc).  They appear to be smaller patch 
> files.  Is this right?

Sounds so. 
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
