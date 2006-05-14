Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWENBMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWENBMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 21:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWENBMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 21:12:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:5324 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932435AbWENBL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 21:11:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSWhQNOA65ojC2rjR6ExRglOslEZSn1uuXqHnw7N+g8B/bxo2AhRwbG4Ch4mNzz+ovcWGxhQESnxew6Rlt5xxvTAB0baxmLtDcvs6whY8gKN+5d/EomADI/sJfECkPMP7C49UMq06hEk3GyauwE+O0qnGzmKX8ztKw45rRjX/rk=
Message-ID: <9e4733910605131811r1a4482d7u6508655e9d3ac376@mail.gmail.com>
Date: Sat, 13 May 2006 21:11:49 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Patrick McFarland" <diablod3@gmail.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Peter Jones" <pjones@redhat.com>, "Martin Mares" <mj@ucw.cz>,
       "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <200605132057.42773.diablod3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <1146778197.27727.26.camel@localhost.localdomain>
	 <1147566572.21291.30.camel@localhost.localdomain>
	 <200605132057.42773.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Patrick McFarland <diablod3@gmail.com> wrote:
> On Saturday 13 May 2006 20:29, Benjamin Herrenschmidt wrote:
> > a long post.
>
> So, why do we insist on keeping legacy hardware around? I mean, serial and
> parallel ports are basically dead, as are ps/2 ports (USB killed them all).
> VGA basically died out when DVI came around. Traditional IA32 is now dying
> out thanks to x86-64. The basic internals have been surplanted by APIC. We
> have a power management API, ACPI, which was unheard of on x86 15 years ago.

Because it is the only video interface we have documentation for.
Almost all of the video hardware can run in non-VGA mode but we don't
have the docs to do this on NVidia/ATI.

It is also a universal interface supported by all video cards. You can
get things like GRUB and the BIOS up on it with minimal code that will
work on all video cards.

To get rid of it the video hardware manufacturers would have to come
together and define a new, open standard. That doesn't look likely to
happen so we are stuck with it. I do agree that it is extremely messy
to work with.

-- 
Jon Smirl
jonsmirl@gmail.com
