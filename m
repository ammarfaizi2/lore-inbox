Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWE2GPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWE2GPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWE2GP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:15:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53951 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751240AbWE2GP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:15:29 -0400
Message-ID: <447A9146.2000602@garzik.org>
Date: Mon, 29 May 2006 02:14:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: "LKML, " <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@muc.de>,
       Andrey Panin <pazke@orbita1.ru>
Subject: Re: Should we make dmi_check_system case insensitive?
References: <200605290131.42292.dtor_core@ameritech.net>
In-Reply-To: <200605290131.42292.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> I have a request to add entry for "LifeBook B Series" to lifebook driver to
> accomodate lifebook B2545, however we already have entry for "LIFEBOOK B
> Series" (used by some other model) which is not working. Would anyone
> be opposed making dmi_check_system() ignore string case? We would have to
> malloc/copy both strings and lowercase them before doing stsstr...   

I was thinking that something like this would eventually be necessary. 
My mind even wandered into the land of wildcards and regexes...

But be wary...  DMI stuff is often used early enough that memory 
allocation may be a bad idea (it seems to use a special dmi_alloc 
function, at the very least).

	Jeff


