Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314282AbSDRJ70>; Thu, 18 Apr 2002 05:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSDRJ7Z>; Thu, 18 Apr 2002 05:59:25 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:22541 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314282AbSDRJ7Z>; Thu, 18 Apr 2002 05:59:25 -0400
Message-Id: <200204180954.g3I9stX00514@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jan Hubicka <jh@suse.cz>
Subject: Re: SSE related security hole
Date: Thu, 18 Apr 2002 12:57:08 -0200
X-Mailer: KMail [version 1.3.2]
Cc: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>, jakub@redhat.com,
        aj@suse.de, ak@suse.de
In-Reply-To: <20020417145130.GA29952@atrey.karlin.mff.cuni.cz> <20020417152337.GG29952@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 April 2002 13:23, Jan Hubicka wrote:
> #include <stdlib.h>
> #include <stdio.h>
>
> int
> m ()
> {
>   int i, n = 7;
>   float comp, sum = 0;
          ^^^^
unused?

>   sin(1);

So, removing this sin() stops the bug?

>   for (i = 1; i <= n; ++i)
>     sum += i;
>   printf ("sum of %d ints: %g\n", n, sum);
>   return 0;
> }
>
> main ()
> {
>   m ();
> }
Can m() body be placed directly in main()?
--
vda
