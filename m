Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWFQSip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWFQSip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWFQSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:38:44 -0400
Received: from mx.laposte.net ([81.255.54.11]:18166 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750840AbWFQSin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:38:43 -0400
From: sebastien cabaniols <sebastien.cabaniols@laposte.net>
Reply-To: sebastien.cabaniols@laposte.net
Organization: nolit a sinargo
To: Bernd Eckenfels <be-news06@lina.inka.de>
Subject: Re: Need to format twice /dev/ramX with reiserfs to be able to mount it ?
Date: Sat, 17 Jun 2006 20:37:30 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <E1FrfJX-0005Qr-00@calista.eckenfels.net>
In-Reply-To: <E1FrfJX-0005Qr-00@calista.eckenfels.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606172037.30805.sebastien.cabaniols@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Samedi 17 Juin 2006 20:14, Bernd Eckenfels wrote:
> sebastien cabaniols <sebastien.cabaniols@laposte.net> wrote:
> > it, so tmpfs is not an option and ext2/ext3 is not an option for other
> > reasons)
>
> just out of couriostity, what might that reason be?

It is a long story,

In fact, when using ext2 instead, I am hitting a second kernel bug or a PXE 
bug (Alan Cox supposition) that I cannot narrow down to something simple.
For a description of the problem see Rick Warner's email (1), he had the very 
same problem (and also probably failed to narrow it down to something easy to 
reproduce) in the past see:

(1) http://lkml.org/lkml/2005/4/28/145

When removing ext2/ext3 from the way, the bug referenced in (1) disappears but 
I need to export the ramdrive data via NFS, hence it excludes tmpfs... But 
now reiserfs don't wan't to mount :-((((((

Since the second bug is very easy to reproduce, I prefered to report this one. 
I am still trying to reduce the original bug to something easy to reproduce 
but it is a lot of work.

Regarding my initial bug report,:

I just manage to reproduce it(the one I am reporting in the previous email) on 
an AMD64/Debian Sarge running 2.6.8. 

I will appreciate any help.
