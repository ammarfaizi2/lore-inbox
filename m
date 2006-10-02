Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965360AbWJBTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbWJBTTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965356AbWJBTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:19:31 -0400
Received: from mail128.messagelabs.com ([216.82.250.131]:24306 "HELO
	mail128.messagelabs.com") by vger.kernel.org with SMTP
	id S965360AbWJBTTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:19:30 -0400
X-VirusChecked: Checked
X-Env-Sender: preece@urbana.css.mot.com
X-Msg-Ref: server-15.tower-128.messagelabs.com!1159816769!1653810!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [129.188.136.8]
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Mon, 2 Oct 2006 14:19:22 -0500 (CDT)
Message-Id: <200610021919.k92JJMs1011215@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: shd@zakalwe.fi
CC: pavel@ucw.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       ext-Tuukka.Tikkanen@nokia.com
In-reply-to: Heikki Orsila's message of Sun, 1 Oct 2006 20:32:52 +0300
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| From: Heikki Orsila<shd@zakalwe.fi>
| 
| On Sun, Oct 01, 2006 at 07:10:32PM +0200, Pavel Machek wrote:
| > On Sun 2006-10-01 18:22:28, Heikki Orsila wrote:
| > > Some nitpicking about the patch follows..
| > > 
| > > On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
| > > > +static long 
| > > > +get_vtg(const char *vdomain)
| > > > +{
| > > > +	long ret = 0;
| > > 
| > > Unnecessary initialisation.
| > 
| > No, sorry.
| 
| In get_vtg(), if VOLTAGE_FRAMEWORK is defined then
| 
| 	ret = vtg_get_voltage(v);
| 
| is the first user. If VOLTAGE_FRAMEWORK is not defined, the first user is:
| 
| 	ret = vtg_get_voltage(&vhandle);
| 
| Then "return ret;" follows. I cannot see a path where 
| pre-initialisation of ret does anything useful. If someone removed the
| #else part, the compiler would bark.
---

True, but a good compiler should remove the dead initialization...

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com


