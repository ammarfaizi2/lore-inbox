Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTFIRfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTFIRfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:35:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264582AbTFIRfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:35:44 -0400
Date: Mon, 9 Jun 2003 13:49:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Eli Carter <eli.carter@inet.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
In-Reply-To: <3EE4C4CD.1050809@inet.com>
Message-ID: <Pine.LNX.4.53.0306091346150.226@chaos>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
 <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com>
 <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com>
 <20030609163959.GA13811@wohnheim.fh-wedel.de>
 <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com>
 <3EE4C4CD.1050809@inet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, Eli Carter wrote:

> Davide Libenzi wrote:
> > On Mon, 9 Jun 2003, [iso-8859-1] J?rn Engel wrote:
> >
> >
> >>In the case of the kernel, there is quite a bit of horrible coding
> >>style.  But a working device driver for some hardware is always better
> >>that no working device driver for some hardware, and if enforcing the
> >>coding style more results is scaring away some driver writers, the
> >>style clearly loses.
> >
> >
> > There's no such a thing as "horrible coding style", since coding style is
> > strictly personal. Whoever try to convince you that one style is better
> > than another one is simply plain wrong. Every reason they will give you to
> > justify one style can be wiped with other opposite reasons. The only
> > horrible coding style is to not respect coding standards when you work
> > inside a project.
>
> I beg to differ: http://www0.us.ioccc.org/2001/anonymous.c ;)
>
> Eli

Last I looked, we had a good example in the Buslogic SCSI driver.
However, just in case it's been changed, I submit herewith an
example of real code written by a "professional".

//
//  This is an example of the kind of 'C' code that is being written
//  by so-called experts. It is unreadable, illogical, but it works.
//  I wish I was kidding!  This is the junk I see being written right
//  now by so-called professional programmers!
//  Richard B. Johnson                              rjohnson@analogic.com
//
//
#include<stdio.h>
#define SuccessfulReturnValue 0
typedef int MainReturnType;
typedef int DefaultCounterType;
typedef void NothingWeCareAbout;
typedef const char StringThatIsntGoingToBeModified;
typedef char StringThatCanBeModified;
MainReturnType main(NothingWeCareAbout);
StringThatIsntGoingToBeModified MessageToBeWrittenToTheScreen[]={0x48,0x64,0x6e,0x6f,0x6b,0x25,0x71,0x68,0x7a,0x65,0x6e,0x2a,0x0c};
MainReturnType main(){
    StringThatCanBeModified LocalStringBuffer[sizeof(MessageToBeWrittenToTheScreen)];
    DefaultCounterType CharacterCounter;
    for(CharacterCounter=0;CharacterCounter<sizeof(MessageToBeWrittenToTheScreen);CharacterCounter++)
        LocalStringBuffer[CharacterCounter]=MessageToBeWrittenToTheScreen[CharacterCounter]^CharacterCounter;
    puts(LocalStringBuffer);
    return SuccessfulReturnValue;
}

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

