Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVCVHSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVCVHSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVCVHSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:18:52 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:46225 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262060AbVCVHSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:18:49 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Date: Tue, 22 Mar 2005 02:13:45 -0500
User-Agent: KMail/1.7.2
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <d120d500050321065261ee815c@mail.gmail.com> <1111419068.8079.15.camel@localhost>
In-Reply-To: <1111419068.8079.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220213.46375.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 10:31, Kenan Esau wrote:
> Am Montag, den 21.03.2005, 09:52 -0500 schrieb Dmitry Torokhov:
> > 
> > There are couple of things that I an concerned with:
> > 
> > 1. I don't like that it overrides meaning of max_proto parameter to be
> > exactly the protocol specified. 
> 
> Yeah -- I agree. I also don't like that double-meaning. That was the
> reason why I originally proposed the use of a new parameter...
> 

Ok, I have some patches to lifebook that I would like to included (if
they work):

1. lifebook-dmi-x86-only - do not compile in DMI detection on anything
   but x86.
   
2. lifebook-cleanup - do not set rate/resolution nor enable the device
   in lifebook initialization routines, let psmouse code do it for us.

3. lifebook-init - rearrange initialization code to be more like other
   protocols to ease dynamic protocol switching.

4. psmouse-proto-attr - expose protocol as a sysfs attribute and allow
   changing it from userspace.

Please give it a try and let me know if it does/does not work.

Thanks!

-- 
Dmitry
