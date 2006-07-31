Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWGaC1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWGaC1T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 22:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGaC1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 22:27:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:28386 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932412AbWGaC1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 22:27:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=NGgyKfnON/mBpG1vUKSm93GduTdQKzVl/V4qPjH2W7q7FGvfrR1D2BE1JAWNFwo8sWOjo4tbdQO90JpjfqlyH3CRSsUAd6b/ApKBdk79a7Vkj/xAmlOIzMOYfTnFaaVOKymf/5TNfat18YxUrCCcUw8nCk/UEYsx4QYc69riSro=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Greg KH <greg@kroah.com>
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Date: Sun, 30 Jul 2006 22:27:06 -0400
User-Agent: KMail/1.9.1
Cc: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>,
       andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org
References: <20060727015639.9c89db57.akpm@osdl.org> <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com>
In-Reply-To: <20060731000359.GB23220@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 20:03, Greg KH wrote:
> Something's really broken with that version of udev then, because the
> 094 version I have running here works just fine with these symlinks.

Maybe, but some really odd things were happening in /sys with the
patch. I could still follow the bogus symlinks. More than that

/sys/class/mem/mem$ cd ../../class
and
/sys/class/mem/mem$ cd ../..

_both_ ended up with a $PWD of /sys/class.

With the patch reverted, udev now works correctly (thanks, Laurent), and
/sys/class/mem/mem$ cd ../../class
fails with the expected error.

Andrew Wade
