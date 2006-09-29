Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWI2Uke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWI2Uke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWI2Ukd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:40:33 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:45910 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932370AbWI2Ukc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:40:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=REgwDFH4e8InR3FxSjzeNdIMGB/nJwU7C5iiWy5p+edHtib8nyd7Ti8qfFLouUhfqNvDD42nMKzVPO2iziepEHwPNClpRo3mGMHqDz79kSZDWPqRVZUARjQzIUCxMntgGTBL1vZuSQlmvx2MOT/yQmAA6WuvHFW4JST+DQ6SlcY=
Message-ID: <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
Date: Fri, 29 Sep 2006 22:40:29 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, jt@hpl.hp.com
In-Reply-To: <20060929202928.GA14000@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
	 <20060929202928.GA14000@tuxdriver.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/06, John W. Linville <linville@tuxdriver.com> wrote:
> On Fri, Sep 29, 2006 at 09:25:53PM +0200, Alessandro Suardi wrote:
> > Dell Latitude D610, FC5-latest, ipw2200 configured to associate
> > with a D-Link DSL-G604T (combo of router/ADSL modem/802.11g AP).
> >
> > 2.6.18-git8 (plus semaphore.h) is ok
> > -git9, -git10, -git11 fail to associate
> > -git11 with reverted wireless changes is ok
> >
> > Attaching diff of what I reverted in -git11 to make it work again.
> >
> > wpa_supplicant log of failing session available upon request.
>
> It looks like you reverted the WE-21 stuff.  Is your wireless-tools
> package up to date?

Well, that's the latest I get under FC5:

[asuardi@sandman ~]$ rpm -q wireless-tools
wireless-tools-28-0.pre13.5.1

 but indeed (-git11 minus the reverts) iwconfig says

[asuardi@sandman ~]$ iwconfig eth1
Warning: Driver for device eth1 has been compiled with version 21
of Wireless Extension, while this program supports up to version 19.
Some things may be broken...

The criteria for the revert was actually "take out anything that
 might remotely hit ipw2200 or wireless" - it was basically to
 first rule out that either my WPA configuration or anything in
 my environment could be at fault.

If you have suggestions about either upgrading wireless-tools
 from a non-FC5 repository or narrowing down the reverts, I'm
 up for giving them a go :)


Thanks, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
