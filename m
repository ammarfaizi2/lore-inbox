Return-Path: <linux-kernel-owner+w=401wt.eu-S1751585AbXAUOBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbXAUOBj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 09:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXAUOBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 09:01:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:6968 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbXAUOBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 09:01:38 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dbEnVoKPwtHL0wUqzbWHjkxB5xTAHX3PQlCa8MXElQ4EffDEjXkL0CgNw0SSHG/P+jtRqG8t+dNSrHugZLVCacuvUibw5uWIWcnZfUHcgFI6ark0ZE2J2y5TylkVqbdm4IGTrETVOUay3MiNYSOUUBKQ6dAxC8kvv+xSOKYvobs=
Message-ID: <45B3723D.4030901@gmail.com>
Date: Sun, 21 Jan 2007 17:01:33 +0300
From: Ivan Ukhov <uvsoft@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: UVSoft@gmail.com
Subject: Re: How to use an usb interface than is claimed by HID?
References: <45B265E0.5020605@gmail.com> <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz> <45B2AA03.4070405@gmail.com> <Pine.LNX.4.64.0701210050490.21127@twin.jikos.cz> <45B32B80.4050208@gmail.com> <Pine.LNX.4.64.0701211358570.21127@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0701211358570.21127@twin.jikos.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> Then, when this is a non-standard situation anyway, would calling 
> hid_disconnect() for the usb_interface of your driver be enough?
>   
I can't even imagine how to call this very function. Could you give me 
an example? After all, this function and friends of its aren't 
EXPORTED_SYMBOLs. Beside it's going to end up depending on the HID 
driver, so the HID driver will have to be loaded all the time even if my 
driver is loaded first and manages to claim the interfaces.

Sorry, I've absolutely forgotten to say that I'm talking about 2.4.x and 
this function looks like:

static void hid_disconnect(struct usb_device *dev, void *ptr);

ptr is a pointer to the struct hid_device structure, which is created 
and initialized in the probe function. Do you offer me to set up this 
structure myself????

Thank you.

Ivan Ukhov.
