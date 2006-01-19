Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWASEZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWASEZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWASEZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:25:19 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:49318 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161293AbWASEZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:25:17 -0500
Date: Wed, 18 Jan 2006 23:20:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: How to discover new Linux features (was: Re: Linux
  2.6.16-rc1)
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200601182323_MC3-1-B627-7710@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060117183916.399b030f.diegocg@gmail.com>

On Tue, 17 Jan 2006, Diego Calleja wrote:

> Can I ask if it's possible to "mark" new features/important changes?
> 
> I've maintaining http://wiki.kernelnewbies.org/LinuxChanges
> for three releases and the amount of changes is so big it takes hours 
> to extract the relevant changes,

 One way to find new features is to use "make oldconfig".

 Say you are comparing kernels 2.6.14 and 2.6.15, trying to see what
is new.  Just do this:

 1.  Copy a .config file into your 2.6.14 directory.

 2.  Run "make oldconfig" there.  It doesn't really matter what
     answers you give so long as it runs to completion.

 3.  Copy that .config file to your 2.6.15 directory.

 4.  When you run "make oldconfig" all of the new features, drivers
     etc. will cause a prompt.

 5.  There will be some false positives if options have been renamed
     or moved around, but it's generally accurate.

-- 
Chuck
Currently reading: _Noise_ by Hal Clement
