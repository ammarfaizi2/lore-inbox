Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVD0Ugi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVD0Ugi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVD0UgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:36:18 -0400
Received: from terminus.zytor.com ([209.128.68.124]:11965 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261998AbVD0UgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:36:10 -0400
Message-ID: <426FF799.4000501@zytor.com>
Date: Wed, 27 Apr 2005 13:35:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
CC: Florian Weimer <fw@DENEB.ENYO.DE>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
       mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de> <426FDFCD.6000309@zytor.com> <20050427190144.GA28848@cip.informatik.uni-erlangen.de>
In-Reply-To: <20050427190144.GA28848@cip.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann wrote:
> Hello,
> 
> 
>>Directory hashing slows down operations that do linear sweeps through 
>>the filesystem reading every single file, simply because without 
>>dir_index, there is likely to be a correlation between inode order and 
>>directory order, whereas with dir_index, readdir() returns entries in 
>>hash order.
> 
> 
> thank you for the awareness training. Than mutt should be slower, too.
> Maybe I should repeat that tests.
> 

Only if you read every single file in each directory every time.  I 
thought mutt did header indexing and thus didn't need to do that.

	-hpa
