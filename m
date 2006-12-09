Return-Path: <linux-kernel-owner+w=401wt.eu-S1030720AbWLIM1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030720AbWLIM1t (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWLIM1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:27:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:16652 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030720AbWLIM1s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:27:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=pdkp/toEXsR1XxnJvy8On5ofRwlDvohioQohHBIUJuN2Ly3H90rBtJ3s50MZxKQpYr9vkyr2QQ5HU6klPNCcFApUzPnMMbrLUE48ZjQzh8+to8ZAoLwSA5LQCxbTcyBniFVucq/vCMU93zupvgvMj9enFj5JkdhhyPutzQPXUTs=
Date: Sat, 9 Dec 2006 13:27:42 +0100
From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Norbert Kiesel <nkiesel@tbdnetworks.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
Message-ID: <20061209132742.7a25dcb5@localhost.localdomain>
In-Reply-To: <20061206131003.GF24140@stusta.de>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com>
	<1165406299.3233.436.camel@laptopd505.fenrus.org>
	<1165407548.5954.224.camel@titan.tbdnetworks.com>
	<20061206131003.GF24140@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 6 Dec 2006 14:10:03 +0100
Adrian Bunk <bunk@stusta.de> escribió:

> On Wed, Dec 06, 2006 at 01:19:08PM +0100, Norbert Kiesel wrote:
> > On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
> > > On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
> > > > Hi,
> > > > 
> > > > I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
> > > > be optimal for a machine with exactly 1GB memory (like my current
> > > > desktop). Why is that option only prompted for after selecting EMBEDDED
> > > > (which I normally don't select for desktop machines
> > > 
> > > because it changes the userspace ABI and has some other caveats.... this
> > > is not something you should muck with lightly 
> > > 
> > 
> > Hmm, but it's also marked EXPERIMENTAL. Would that not be the
> > sufficient?  Assuming I don't use any external/binary drivers and a
> > self-compiled kernel w//o any additional patches: is there really any
> > downside?
> 
> - Wine doesn't work (I'm not sure about VMSPLIT_3G_OPT, but
>                      VMSPLIT_2G definitely breaks Wine)

 I use VMSPLIT_3G_OPT=y and wine works just fine (only tested with one
 program). Edgy + 2.6.19-rc1



> - AFAIR some people reported problems with some Java programs
>   after fiddling with the vmsplit options
> 
> EMBEDDED isn't exactly the right way to hide it, but the vmsplit options 
> aren't something you can safely change.
> 
> > </nk>
> 
> cu
> Adrian
> 
