Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWBTLZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWBTLZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWBTLZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:25:27 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:5126 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932586AbWBTLZ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:25:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JIbRTQGPRQ6jy0aI3nO55kJYrihTQeXi+kH7X+8XCRmSo67GAUbEWp1H5uneWQSE3wnXM0ncMHm2VcIBjeIMbCF3Oku45scyrAkTV5COabVBFPE1xT4i9FhZlaJHSCo+2LPf2pxpydtC6z/0OoUz6CrhgL7KSYgPndiHWHlMMl8=
Message-ID: <756b48450602200325v28f0300cu8b4845ab9dba9a4c@mail.gmail.com>
Date: Mon, 20 Feb 2006 19:25:26 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060220110145.GB4489@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com>
	 <20060220102639.GA4342@srcf.ucam.org>
	 <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com>
	 <20060220110145.GB4489@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Feb 20, 2006 at 06:49:54PM +0800, Jaya Kumar wrote:
>
> > I'm not sure how standard that is. For example, I looked at the asus
> > and toshiba drivers. These ACPI board drivers use
> > /proc/acpi/somedevice/lcd. For example,
>
> And, from a userspace perspective, it sucks. I'm in the process of
> writing patches to transition them all over, and I'd prefer not to have
> to write one for your driver as well :)

I have some questions then.
1. Are Patrick's acpi driver model changes considered to be a more
final approach that standardize everyone to some sysfs based interface
to userspace?
1a. Can I assume there is consensus among the acpi community around
his new model?
2. Is his driver model going to maintain compatibility with the older
existing /proc model and those userspace apps that already use that
interface?
3. Is his driver model going to also maintain compatibility with your
newer model (assuming that his model is different than yours).

>
> > I'll go take a look at that. I didn't look for an acpi driver outside
> > of the drivers/acpi directory. But if that's the consensus, shouldn't
> > someone also mod the toshiba and asus drivers?
>
> I'm doing so.

Ok. I wish I'd known before. I scanned the mailing list before
mbarking on this to see if any issues were raised with toshiba and
asus driver code and didn't see anything. FWIW, my powers of mind
reading only work on Fridays. :-)

> Doing it via the input layer adds flexibility - it makes it easier for
> non-root uesrspace to handle things, but you can still have a root-level
> daemon that monitors /dev/input/event* and runs commands in response to
> keycodes.
>

Oh. I don't disagree with that.

Thanks,
jayakumar
