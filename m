Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267803AbTB1MHy>; Fri, 28 Feb 2003 07:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTB1MHy>; Fri, 28 Feb 2003 07:07:54 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:63635 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267803AbTB1MHx>; Fri, 28 Feb 2003 07:07:53 -0500
Message-ID: <20030228121806.16285.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 13:18:06 +0100
Subject: Re: anticipatory scheduling questions
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Andrew Morton <akpm@digeo.com> 
Date: Thu, 27 Feb 2003 15:26:04 -0800 
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> 
Subject: Re: anticipatory scheduling questions 
 
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote: 
> > Indeed, this can be tested interactively with an application like Evolution: 
> > I have configured Evolution to use 2 dictionaries (English and Spanish) for 
> > spell checking in e-mail messages. When running 2.4.20, if I choose to reply 
> > to a large message, it only takes a few seconds to read both dictionaries 
> > from disk and perform the spell checking.  
> > However, on 2.5.63-mm1 the same process takes considerably longer. Any 
> > reason for this?  
>  
> Could you boot with elevator-deadline and retest? 
 
I have done benchmark tests with Evolution under the following conditions: (times measured since the reply 
button is clicked until the message is opened) 
 
2.4.20-2.54 -> 9s 
2.5.63-mm1 w/Deadline -> 34s 
2.5.63-mm1 w/AS -> 33s 
 
The 2.4.20-2.54 is *not* a stock kernel, but Red Hat's own patched kernel (I think they include most of Alan Cox 
patches). Times are measured manually (don't know how to "time" the time elapsed since I click a button and 
the reply window is opened). Also, the filesystem is "ext2" running on a laptop (not a really fast hard disk). 
 
> How large are the dictionary files? 
 
Well, the aspell dictionary files are roughly 16MB for the Spanish dictionary and 4MB for the English one. 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
