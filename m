Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751999AbWG2BoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWG2BoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 21:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWG2BoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 21:44:03 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:36770 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751999AbWG2BoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 21:44:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HADRaykSBUw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [RFC] #define rwxr_xr_x 0755
Date: Fri, 28 Jul 2006 21:43:57 -0400
User-Agent: KMail/1.9.3
Cc: Handle X <xhandle@gmail.com>,
       =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
References: <20060727205911.GB5356@martell.zuzino.mipt.ru> <6de39a910607280934t5c264b20w38c1f52c978b4e15@mail.gmail.com> <20060728164839.GA20974@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060728164839.GA20974@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607282143.58915.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 12:48, Josef Sipek wrote:
> On Fri, Jul 28, 2006 at 09:34:11AM -0700, Handle X wrote:
> > On 7/27/06, Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > >On 2006.07.28 00:59:11 +0400, Alexey Dobriyan wrote:
> > >> Every time I try to decipher S_I* combos I cry in pain. Often I just
> > >> refer to include/linux/stat.h defines to find out what mode it is
> > >> because numbers are actually quickier to understand.
> > >>
> > >> Compare and contrast:
> > >>
> > >>       0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> > >>
> > >> I'd say #2 really sucks.
> > >
> > >IMHO #3 sucks more, it's not as easy to spot when glossing over the
> > >code, the underscores make it quite ugly (think _r________) and it's
> > >less "greppable". If I know that there's something that sets S_ISUID, I
> > >can easily search for that, compare that to [_cpdbl]{1}[r_]{1}[w_]{1}s...
> > I agree with Steinbink. But how about having macros like,
> > S_I0700, S_I0070, S_I6444 ..etc. They combine visual appeal of octals,
> > easy to grep, easy to decipher ...etc.
> 
> Even better!
> 

So now tell me how is S_I0644 better than 0644? S_IRUGO et al at least hide
implementation details.

-- 
Dmitry
