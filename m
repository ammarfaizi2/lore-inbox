Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVKADVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVKADVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVKADVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:21:16 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:38041 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964957AbVKADVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:21:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Kernel Badness 2.6.14-Git
Date: Mon, 31 Oct 2005 22:21:12 -0500
User-Agent: KMail/1.8.3
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, rml@novell.com
References: <4362BFF1.3040304@linuxwireless.org> <20051029031706.GA26123@kroah.com>
In-Reply-To: <20051029031706.GA26123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312221.13217.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 22:17, Greg KH wrote:
> On Fri, Oct 28, 2005 at 06:18:57PM -0600, Alejandro Bonilla Beeche wrote:
> > Hi,
> > 
> >    I just pulled from Linus Tree and I'm getting this badness in dmesg.
> > 
> > Please let me know if it is too soon to start reporting this. 2.6.14 is 
> > OK and does not output this.
> 
> If you disable PNP does it go away?
> 
> Dmitry, any thoughts?  This looks like the other reported issue.
>

I was looking and looking and the only thing I could come up with is
that we probably need to initialize input core earlier, before other
modules had a chance to use input interface so input class is fully
initialized. We don't need to have input/{ev|mouse|ts|joy}dev.o,
just input/input.o itself.

-- 
Dmitry
