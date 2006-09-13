Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWIMSNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWIMSNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWIMSNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:13:16 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:10633 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750999AbWIMSNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:13:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r3c4IkbFizfmtRFXsMsiu19jCNXz4LHilRCI5Yd44MaV4nIMTepXkcT10FFcPfPbHfOSt1sHbCXnsteS25AcKdHD9w7v1r8MnvqPKW4Vq7dYczZzF7PBfpkvBx47kSJNBQdpT6CK2xgkMpcmgCVLvpjj92BYPAaJ+wafYH6u21k=  ;
Message-ID: <45084A2C.8030804@yahoo.com.au>
Date: Thu, 14 Sep 2006 04:13:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
References: <44F395DE.10804@yahoo.com.au>  <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <45084833.4040602@yahoo.com.au> <Pine.LNX.4.64.0609131106260.18264@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609131106260.18264@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 14 Sep 2006, Nick Piggin wrote:
> 
> 
>>Comments?
> 
> 
> You only support 64k waiters. We have had cases of software failing 
> because more than 64k readers were waiting.

Oh really? OK I figured if ppc64 was OK then that would be enough,
but your large Altix systems did slip my mind.

That is a fair criticism... atomic_long it will have to be, then.
That will require a bit of atomic work to get atomic64_cmpxchg
available on all 64-bit architectures.

> Please sent patches inline in order for us to be able to comment.

OK I will for next patchset.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
