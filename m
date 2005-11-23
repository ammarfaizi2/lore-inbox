Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVKWOZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVKWOZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKWOZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:25:21 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61365 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750825AbVKWOZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:25:19 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: Use enum to declare errno values
Date: Wed, 23 Nov 2005 16:24:49 +0200
User-Agent: KMail/1.8.2
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com> <Pine.LNX.4.61.0511230908320.17975@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511230908320.17975@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511231624.49208.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 16:19, linux-os (Dick Johnson) wrote:
> > I'm just wondering why not declaring errno values using enumaration ?
> > It is just more convenient when debuging the kernel.
> >
> > Thanks
> 
> There is an attempt to keep kernel errno values similar to
> user-mode errno values. This simplifies the user-kernel
> interface where the kernel will return -ERRNO and the user-mode
> code negates it and puts it into the user errno then sets the
> return value to -1 (a Unix convention).
> 
> The user-mode errno's therefore must correspond. You can't
> expect the 'C' runtime libraries to be rebuilt and/or all the
> programs recompiled just because the kernel got changed so
> the errno's are hard-coded. 0 will always mean "no error" and
> 1 will always be EPERM, etc. There are error-codes that are
> the same number also, EWOULDBLOCK and EAGAIN are examples.
> 
> So, you can't just auto-enumerate. If auto-enumeration isn't
> possible, then you might just as well use #define, which is
> what is done.

?!!

enum {
	one,
	two,
	ten = 10
};

--
vda
