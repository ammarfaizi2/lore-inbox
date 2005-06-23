Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVFWU7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVFWU7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVFWU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:57:43 -0400
Received: from cytosin.uni-konstanz.de ([134.34.240.61]:9651 "EHLO
	cytosin.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262691AbVFWUuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:50:00 -0400
From: Michael Dreher <michael.dreher@uni-konstanz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Date: Thu, 23 Jun 2005 22:49:47 +0200
User-Agent: KMail/1.6.2
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, ninja@slaphack.com,
       reiser@namesys.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       reiserfs-list@namesys.com
References: <42BAC304.2060802@slaphack.com> <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <20050623221222.33074838.reiser4@blinkenlights.ch>
In-Reply-To: <20050623221222.33074838.reiser4@blinkenlights.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506232249.47302.michael.dreher@uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>                                                 Not everyone will want
>>> to reformat at once, but as the reiser4 code matures and proves itself
>>> (even more than it already has),
>>
>> I for one have seen mainly people with wild claims that it will make
>> their machines much faster, and coming back later asking how they can
>> recover their thrashed partitions...
>
> Then please show us some Links/Message-IDs to such postings.
> I'd like to read them.

Here you are....

The following happened to me with reiserfs as it was shipped with
suse 9.1:

------------------------------------------------------------------
dreher@euler03:~/mytex/konstanz/wohnung> ls
auto          makler2.aux  makler2.log  makler2.tex  makler.aux  makler.log  
swk.eps      unilogo.eps
briefkpf.tex  makler2.dvi  makler2.ps   makler3.tex  makler.dvi  makler.tex  
unikopf.tex
dreher@euler03:~/mytex/konstanz/wohnung> rm *.aux *.log
rm: cannot remove `makler2.log': No such file or directory
dreher@euler03:~/mytex/konstanz/wohnung> ls
auto  briefkpf.tex  makler2.dvi  makler2.ps  makler2.tex  makler3.tex  
makler.dvi  makler.tex  swk.eps  unikopf.tex  unilogo.eps
dreher@euler03:~/mytex/konstanz/wohnung> uname -a
Linux euler03 2.6.5-7.108-smp #1 SMP Wed Aug 25 13:34:40 UTC 2004 i686 i686 
i386 GNU/Linux
dreher@euler03:~/mytex/konstanz/wohnung> date
Tue Sep 21 13:15:45 CEST 2004
----------------------------------------------------------

Note the line "rm: cannot remove `makler2.log': No such file or directory"

There was no data loss, but such a bug should not happen.
I never had similar experiences with ext3.

Unfortunately, I cannot reproduce this behavior. 

>  Powerloss, unpluging the Disk while writing, full filesystem,
>  heavy use : No problems with reiser4.. It *is* stable.

My impression: reiser3 is not 100% stable, but quite stable, 
written by someone who asks for "review by benchmark".

Michael
