Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWG1F2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWG1F2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG1F2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:28:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21861 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751285AbWG1F2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:28:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TwSVkd4esF8HuH8bPkzQkQ7do9f3Ia1VucQ9Z6Ls9iwXTaDlw0xCDq37rz/Aw4jcuQRxGN6NIIHZoy3MnFYZ/NmQ3KNlfzN3lFP8GSnSbW73hvku3ChgK53d2CF4iTXAhrT10W0intLS0BU2eMVHBnXoO4jC2NHrxmUjgWc7B28=
Message-ID: <6de39a910607272228o26ab51cbw8aaa7215f5fadb8@mail.gmail.com>
Date: Thu, 27 Jul 2006 22:28:18 -0700
From: "Handle X" <xhandle@gmail.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: Can we ignore errors in mcelog if the server is running fine
Cc: "Vikas Kedia" <kedia.vikas@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <44C9155D.5060102@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.2RkKSvRvPsGNSGCsUHQ9gQ8qlrg@ifi.uio.no>
	 <44C9155D.5060102@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Robert Hancock <hancockr@shaw.ca> wrote:
> Vikas Kedia wrote:
> > The server seems to be running fine. A. can I ignore the following
> > mcelog errors ? B. If not what should i do to stop the server from
> > reporting mcelog errors.
>
> Looks like data cache ECC errors, meaning the CPU 0 is faulty.
> Eventually if it's not replaced there will likely be some uncorrectable
> errors and the system will likely crash.

I am facing similar, but different errors.

[root@turyxsrv ~]# mcelog
MCE 0
HARDWARE ERROR. This is *NOT* a software problem!
Please contact your hardware vendor
CPU 1 4 northbridge TSC 89a560bb249
ADDR 1dfa49690
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 2021
       bit46 = corrected ecc error
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS 9410c00020080a13 MCGSTATUS 0
MCE 1
HARDWARE ERROR. This is *NOT* a software problem!
Please contact your hardware vendor
CPU 1 4 northbridge TSC a6550f2d4de
ADDR 1de74b670
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 2021
       bit32 = err cpu0
       bit46 = corrected ecc error
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS 9410c00120080813 MCGSTATUS 0
MCE 2
HARDWARE ERROR. This is *NOT* a software problem!
Please contact your hardware vendor
CPU 1 4 northbridge TSC afe4eba238a
ADDR 1d8049698
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 2021
       bit46 = corrected ecc error
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS 9410c00020080a13 MCGSTATUS 0
MCE 3
HARDWARE ERROR. This is *NOT* a software problem!
Please contact your hardware vendor
CPU 1 4 northbridge TSC cc945738d0a
ADDR 194c4b670
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 2021
       bit40 = error found by scrub
       bit46 = corrected ecc error
  bus error 'local node response, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS 9410c10020080a13 MCGSTATUS 0

Repeats whenever I do any kind of operations...
How severe is ChipKill errors? Should I consider throwing away CPU 1
and get another one.

Regards,
Om.
