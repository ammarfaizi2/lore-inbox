Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUBDX5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUBDXzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:55:16 -0500
Received: from www.trustcorps.com ([213.165.226.2]:21265 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S265059AbUBDXya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:54:30 -0500
Message-ID: <4021858F.1070405@hcunix.net>
Date: Wed, 04 Feb 2004 23:51:43 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Valdis.Kletnieks@vt.edu, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: Your message of "Wed, 04 Feb 2004 12:05:07 EST."             <40212643.4000104@tmr.com> <200402041714.i14HEIVD005246@turing-police.cc.vt.edu> <402184AA.2010302@tmr.com>
In-Reply-To: <402184AA.2010302@tmr.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> But what happens when the 'setgid' bit is put on a directory? At least 
> in 2.4 existing files do NOT get the group set, only files newly 
> created. So unless someone feels that's a bug which needs immediate 
> fixing, I can point to it as a model by which the feature could be 
> practically implemented.
> 
> Comment?
> 
> 


So the proposal is specifically:

if a directory has its chattr 's' "bit" set, then all newly created 
files within that directory inherit the chattr 's' "bit".

Personally, I think that extends beyond simply privacy protection, and 
addresses how chattr values are handled by the file system. Privacy 
protection wouldn't affect the way in which the chattr values are 
handled, so if they are inherited through directories then fine... but I 
don't see this as specific to secure deletion.


--gq
