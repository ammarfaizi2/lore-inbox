Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWHARFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWHARFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWHARFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:05:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:4006 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751678AbWHARFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:05:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=osOFnuly+mtEzmEQ70me1xQvif+Ro97w3OBmWUuWOPfOg4HQ0MxP2yS/eszo0zjDsivG3u9Jx4SBMeCzQGZfDBjWkdn+aj6TuyyH1IeAcq1prwmHlQ1N7ULuTR3SjOMR5MhMk0QmkJrsGocnIr/OZjXDYCSSRurWQSsqNrjGlmQ=
Message-ID: <e692861c0608011004x2ac1d9fcu353cd8e0d72eaac4@mail.gmail.com>
Date: Tue, 1 Aug 2006 13:04:56 -0400
From: "Gregory Maxwell" <gmaxwell@gmail.com>
To: "David Masover" <ninja@slaphack.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Adrian Ulrich" <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44CF84F0.8080303@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607312314.37863.bernd-schubert@gmx.de>
	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
	 <1154446189.15540.43.camel@localhost.localdomain>
	 <44CF84F0.8080303@slaphack.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, David Masover <ninja@slaphack.com> wrote:
> Yikes.  Undetected.
>
> Wait, what?  Disks, at least, would be protected by RAID.  Are you
> telling me RAID won't detect such an error?

Unless the disk ECC catches it raid won't know anything is wrong.

This is why ZFS offers block checksums... it can then try all the
permutations of raid regens to find a solution which gives the right
checksum.

Every level of the system must be paranoid and take measure to avoid
corruption if the system is to avoid it... it's a tough problem. It
seems that the ZFS folks have addressed this challenge by building as
much of what is classically separate layers into one part.
