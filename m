Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSFFTY7>; Thu, 6 Jun 2002 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSFFTY6>; Thu, 6 Jun 2002 15:24:58 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:2002 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317114AbSFFTY4>; Thu, 6 Jun 2002 15:24:56 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [RFC] 4KB stack + irq stack for x86
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF70FD985F.A9C66B00-ONC1256BD0.0069C993@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 6 Jun 2002 21:24:32 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/06/2002 21:24:43
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete Zaitcev wrote:

>> Of course, the situation is particularly bad on s390, because every
>> function call needs at least 96 bytes on the stack (due to the register
>> save areas required by our ABI).
>
>How is this different from sparc64?

Well, I guess it's similar on sparc.  I'm not sure about the size of the
save areas needed on sparc, though.  In any case both sparc and s390 are
certainly much worse w.r.t. stack space usage than i386 ...

(*Really* ugly is s390x, because we need about twice as much stack on
average than on s390, but page size is still only 4K -- most other 64-bit
platforms have 8K page size ...)


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

