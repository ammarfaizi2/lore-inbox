Return-Path: <linux-kernel-owner+w=401wt.eu-S1751070AbXACTEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbXACTEo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbXACTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:04:44 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44957 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbXACTEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:04:42 -0500
Date: Wed, 3 Jan 2007 20:04:41 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: matthew@wil.cx, pavel@ucw.cz, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0701032003120.6871@artax.karlin.mff.cuni.cz>
References: <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
 <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
 <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
 <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Miklos Szeredi wrote:

>>> High probability is all you have.  Cosmic radiation hitting your
>>> computer will more likly cause problems, than colliding 64bit inode
>>> numbers ;)
>>
>> Some of us have machines designed to cope with cosmic rays, and would be
>> unimpressed with a decrease in reliability.
>
> With the suggested samefile() interface you'd get a failure with just
> about 100% reliability for any application which needs to compare a
> more than a few files.  The fact is open files are _very_ expensive,
> no wonder they are limited in various ways.
>
> What should 'tar' do when it runs out of open files, while searching
> for hardlinks?  Should it just give up?  Then the samefile() interface
> would be _less_ reliable than the st_ino one by a significant margin.

You could do samefile() for paths --- as for races --- it doesn't matter 
in this scenario, it is no more racy than stat or lstat.

Mikulas

> Miklos
>
