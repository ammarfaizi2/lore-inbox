Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSDUKSM>; Sun, 21 Apr 2002 06:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSDUKSL>; Sun, 21 Apr 2002 06:18:11 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8713 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313093AbSDUKSJ>; Sun, 21 Apr 2002 06:18:09 -0400
Message-Id: <200204211015.g3LAFCX08450@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: andersen@codepoet.org, "Dr. Death" <drd@homeworld.ath.cx>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Date: Sun, 21 Apr 2002 13:18:23 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBEC67F.3000909@filez> <20020419200112.GA16209@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 April 2002 18:01, Erik Andersen wrote:
> On Thu Apr 18, 2002 at 03:13:35PM +0200, Dr. Death wrote:
> > Problem:
> >
> > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a
> > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the
> > damaged part of the file !
>
> This should help somewhat.  Currently, ide-cd.c retries ERROR_MAX
> (8) times when it sees an error.  But ide.c is also retrying
> ERROR_MAX times when _it_ sees an error, and does a bus reset
> after evey 4 failures.  So for each bad sector, you get 64
> retries (with typical timouts of 7 seconds each) plus 16 bus
> resets per bad sector.

And nobody knows how many tries is in hardware...
so we get 8x8x?? retries, and *this* is slow.
--
vda
