Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSDJEmB>; Wed, 10 Apr 2002 00:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSDJEmA>; Wed, 10 Apr 2002 00:42:00 -0400
Received: from 202-77-223-23.outblaze.com ([202.77.223.23]:48616 "EHLO
	testdcc.outblaze.com") by vger.kernel.org with ESMTP
	id <S293713AbSDJEmA>; Wed, 10 Apr 2002 00:42:00 -0400
Message-ID: <20020410044156.2881.qmail@fastermail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "mark manning" <mark.manning@fastermail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 09 Apr 2002 23:41:56 -0500
Subject: Re: nanosleep
X-Originating-Ip: 67.241.61.228
X-Originating-Server: ws4.hk5.outblaze.com
X-DCC-Outblaze-Metrics: testdcc.outblaze.com 100; env_From=9 From=9 Message-ID=1 Received=1 Body=1
	Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thanx - how much of a difference should i expect - i know the syscall is asking for at least the required ammount but that the task switcher might not give me control back for a while after the requested delay but i was expecting to be a little closer to what i had asked for - this isnt critical of corse but i would like to know what to expect.


----- Original Message -----
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 09 Apr 2002 21:17:03 -0700
To: mark manning <mark.manning@fastermail.com>
Subject: Re: nanosleep


> mark manning wrote:
> > doh - i think something is still wrong, i ask for 1000 ms and i get a second but if i do a 500 itteration loop asking for 1 ms i get 5 seconds.  i am also starting to distrust my elapsed time display which is using the gettimeofday syscall
> > 
> 
> It doesn't work that way.  Each call to nanosleep() gives you a 
> *MINIMUM* time to delay.  The kernel may decide to schedule you away and 
> pick your process up when it suits it.
> 
> 	-hpa
> 
> 
> 

-- 

_______________________________________________
Get your free email from http://www.fastermail.com

Powered by Outblaze
