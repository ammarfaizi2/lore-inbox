Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSAXTVh>; Thu, 24 Jan 2002 14:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSAXTV1>; Thu, 24 Jan 2002 14:21:27 -0500
Received: from [24.64.71.161] ([24.64.71.161]:2036 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288952AbSAXTVR>;
	Thu, 24 Jan 2002 14:21:17 -0500
Date: Thu, 24 Jan 2002 12:19:52 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Can linux support ccNUMA machine now?
Message-ID: <20020124121952.A763@lynx.adilger.int>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com> <74750000.1011782724@flay> <20020123200405.D899@holomorphy.com> <200201241215.g0OCFSE10537@Port.imtp.ilyichevsk.odessa.ua> <20020124105008.E872@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020124105008.E872@holomorphy.com>; from wli@holomorphy.com on Thu, Jan 24, 2002 at 10:50:08AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 24, 2002  10:50 -0800, William Lee Irwin III wrote:
> On Thu, Jan 24, 2002 at 02:15:30PM -0200, Denis Vlasenko wrote:
> > Looks like running x86 with more than 16GB RAM is not a good idea.
> > If you need it, you need 64bit arch.

Actually, Andrea made a patch to move the page tables into HIMEM on
such machines.  I believe it is in the latest -aa patch.

> Reducing overhead helps all boxen everywhere all the time. Turning the
> kernel upside-down for the corner case of 64GB isn't worth it, but
> finding more graceful ways to fail than not booting with no visible
> error messages, and perhaps extending the range of configurations where
> the kernel actually functions (within reason) by reducing space
> overhead is worthwhile.

Yes, there also have been several patches floating around to reduce
the size of struct page.  I don't think any are in the kernel yet.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

