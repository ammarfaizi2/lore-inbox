Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVCaTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVCaTlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVCaTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:41:36 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:19891 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261667AbVCaTlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:41:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: romano@dea.icai.upco.es
Subject: Re: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
Date: Thu, 31 Mar 2005 13:09:49 -0500
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com> <20050331165007.GA29674@pern.dea.icai.upco.es>
In-Reply-To: <20050331165007.GA29674@pern.dea.icai.upco.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311309.50165.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 11:50, Romano Giannetti wrote:
> On Thu, Mar 31, 2005 at 10:15:26AM -0500, Dmitry Torokhov wrote:
> > On Thu, 31 Mar 2005 16:47:29 +0200, Romano Giannetti <romanol@upco.es> wrote:
> > > 
> > > The bad news is that with 2.6.12-rc1 (no preempt) swsusp fails to go.
> > 
> > Ok, I see you have an ALPS touchpad. I think this patch will help you
> > with swsusp:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111212532524998&q=raw
> 
> Yes! With this it works ok.
> 
> > Also, could you please try sticking psmouse_reset(psmouse) call at the
> > beginning of drivers/input/mouse/alps.c::alps_reconnect() and see if
> > it can suspend _without_ the patch above.
> 
> It works, too. Which one is the best one? 
>

Both of them are needed as they address two different problems.

-- 
Dmitry
