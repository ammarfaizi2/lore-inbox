Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbUJZGVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbUJZGVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUJZGVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:21:50 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:53681 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262144AbUJZGVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:21:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: ncunningham@linuxmail.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Date: Tue, 26 Oct 2004 01:21:46 -0500
User-Agent: KMail/1.6.2
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200410210154.58301.dtor_core@ameritech.net> <200410250822.46023.dtor_core@ameritech.net> <1098744035.7191.49.camel@desktop.cunninghams>
In-Reply-To: <1098744035.7191.49.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410260121.46633.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 09:28 pm, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2004-10-25 at 23:22, Dmitry Torokhov wrote:
> > The change from sysdev to a platform device is the main reason I did
> > the change (and getting rid of old pm_register stuff which is useless
> > now) because swsusp2 (and seems that swsusp1 as well) have trouble
> > resuming system devices. The rest was just fluff really.
> 
> I'm not sure why we're not trying to resume system devices. I'll give it
> a whirl and see if anything breaks :> Feel free to tell me if/when you
> notice things like this in future; I try to be approachable and
> responsive.
> 

Hi Nigel,
 
System devices are resumed when you call device_power_up and I could
not find references to it in swsusp2 code, it goes straight to
device_resume_tree... Am I missng something?

-- 
Dmitry
