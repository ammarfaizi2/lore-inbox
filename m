Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136646AbREAQLW>; Tue, 1 May 2001 12:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136645AbREAQLN>; Tue, 1 May 2001 12:11:13 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:62632 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136641AbREAQLI>; Tue, 1 May 2001 12:11:08 -0400
Message-ID: <3AEEDFFC.409D8271@redhat.com>
Date: Tue, 01 May 2001 12:10:36 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> 
> Chris.Roets@compaq.com said:
> > So, will Linux ever support the scsi reservation mechanism as standard?
> 
> That's not within my gift.  I can merely write the code that corrects the
> behaviour.  I can't force anyone else to accept it.

I think it will be standard before not too much longer (I hope anyway, I'm
tired of carrying the patches forward all the time so I'll lend my support to
getting it into the mainstream kernel ;-)

> Chris.Roets@compaq.com said:
> > Isn't there a standard that says if you scsi reserve a disk, no one
> > else should be able to access this disk, or is this a "steeleye/
> > Compaq" standard.
> 
> Use of reservations is laid out in the SCSI-2 and SCSI-3 standards (which can
> be downloaded from the T10 site www.t10.org) which are international in scope.
>  I think the implementation issues come because the reservations part is
> really only relevant to a multi-initiator clustered environment which isn't an
> every day configuration for most Linux users.  Obviously, as Linux moves into
> the SAN arena this type of configuration will become a lot more common, at
> which time the various problems associated with multiple initiators should
> rise in prominence.

I agree.  It's something that needs fixed in general, your software needs it
as well, and I've written (about 80% done at this point) some open source
software geared towards getting/holding reservations that also requires the
same kernel patches (plus one more to be fully functional, an ioctl to allow a
SCSI reservation to do a forced reboot of a machine).  I'll be releasing that
package in the short term (once I get back from my vacation anyway).

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
