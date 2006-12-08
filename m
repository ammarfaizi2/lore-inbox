Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032533AbWLHIw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032533AbWLHIw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 03:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032532AbWLHIw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 03:52:29 -0500
Received: from hu-out-0506.google.com ([72.14.214.225]:24029 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425209AbWLHIw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 03:52:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Dohu1BQM0fM7iXHZc6Ya/uYFp/XSgtC7QtrV8l7x5plS4egOBd35Dp+/yMsTGlpgMfvclbTd2nWVZclJZWay6byuUv6QHEPWXZFD9MTZn4M1daDNOcVX7A9iZ+bCqAV1rraxpUSQxftEB/LbrCbmBerxUE8E/T+f3DokSWN/I3Q=
Message-ID: <86802c440612080052x3704d767p8bfeb7fb723c9883@mail.gmail.com>
Date: Fri, 8 Dec 2006 00:52:26 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Cc: ebiederm@xmission.com, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <20061208071437.GA23173@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	 <20061208071437.GA23173@suse.de>
X-Google-Sender-Auth: 5160cd96fc871fb1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, Greg KH <gregkh@suse.de> wrote:
> Ugh, no, never use the usb-serial driver as a console device.
>
> That was a bad hack done as a bet many years ago.  For many obvious
> reasons it does not work well.
understood, I found with usb_serial convertor could lose some chatacter.
but the usb-debug cable seem it keep all character.
>
> > host with cat /dev/ttyUSB0
> > But if use minicom in host, it will not show '\r', I guess the usb debug
> > cable eat return char. Greg, Can you add that back in usb_debug by
> > replacing '\n' with '\r', '\n'?
>
> The usb-serial console code should handle this, I thought we fixed it a
> while ago.
Is it in the git tree?
>
> But this kind of interface is not what these devices are good for.  They
> are for the debug port information, not as a usb-serial console device.
> Otherwise they are way too expensive of a device...
the problem is some "modern" PC will left out serial port. then the cable
could get cheap.

YH
