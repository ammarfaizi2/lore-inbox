Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWJDVen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWJDVen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWJDVen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:34:43 -0400
Received: from mail125.messagelabs.com ([85.158.136.35]:45844 "HELO
	mail125.messagelabs.com") by vger.kernel.org with SMTP
	id S1751153AbWJDVem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:34:42 -0400
X-VirusChecked: Checked
X-Env-Sender: preece@urbana.css.mot.com
X-Msg-Ref: server-4.tower-125.messagelabs.com!1159997669!11119996!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [129.188.136.8]
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Wed, 4 Oct 2006 16:33:46 -0500 (CDT)
Message-Id: <200610042133.k94LXkDq016761@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: pavel@ucw.cz
CC: shd@zakalwe.fi, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       ext-Tuukka.Tikkanen@nokia.com
In-reply-to: Pavel Machek's message of Wed, 4 Oct 2006 23:25:45 +0200
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| From: Pavel Machek<pavel@ucw.cz>
| 
| Hi!
| 
| > | > > > +static long 
| > | > > > +get_vtg(const char *vdomain)
| > | > > > +{
| > | > > > +	long ret = 0;
| > | > > 
| > | > > Unnecessary initialisation.
| > | > 
| > | > No, sorry.
| > | 
| > | In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
| > | 
| > | 	ret = vtg_get_voltage(v);
| > | 
| > | is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:
| > | 
| > | 	ret = vtg_get_voltage(&vhandle);
| > | 
| > | Then "return ret;" follows. I cannot see a path where 
| > | pre-initialisation of ret does anything useful. If someone removed the
| > | #else part, the compiler would bark.
| > ---
| > 
| > True, but a good compiler should remove the dead initialization...
| 
| True, but efficient code is only one of constraints. Code should be
| easy to read, too.
| 								Pavel
| -- 
| (english) http://www.livejournal.com/~pavelmachek
| (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

[Ironically, I was going to say "I think this dead horse has been
sufficiently beaten, but then I saw the picture reference in Pavel's
signature and decided that would be rude!]

I agree - the initialization is unneeded. However, it's also mostly
harmless...

scott

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com


