Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262907AbTCKMLi>; Tue, 11 Mar 2003 07:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbTCKMLi>; Tue, 11 Mar 2003 07:11:38 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:33676 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262907AbTCKMLh>; Tue, 11 Mar 2003 07:11:37 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF690DDAD1.0533780B-ONC1256CE6.00437602@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 11 Mar 2003 13:20:39 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 11/03/2003 13:21:57
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Did you notice the use of the address conversion macro? Maybe I missed
> something myself, but I suppose this will fail on s390 if the msb of arg
> is not cleared.

True. A(arg) removes the high order bit from arg. This can't be done
in the system call wrapper because in general arg is a 32 bit parameter.

blue skies,
   Martin


