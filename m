Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268825AbUHZMOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268825AbUHZMOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268820AbUHZMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:13:56 -0400
Received: from ee.oulu.fi ([130.231.61.23]:49890 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S268892AbUHZMHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:07:11 -0400
Date: Thu, 26 Aug 2004 15:07:04 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: linux-kernel@vger.kernel.org
cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: kernel 2.6.8 pwc patches and counterpatches
In-Reply-To: <200408261317.18781.oliver@neukum.org>
Message-ID: <Pine.GSO.4.61.0408261436500.16780@stekt37>
References: <1092793392.17286.75.camel@localhost> <cgi65a$s76$1@sea.gmane.org>
 <Pine.GSO.4.61.0408261201490.16780@stekt37> <200408261317.18781.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Oliver Neukum wrote:

> Am Donnerstag, 26. August 2004 11:22 schrieb Tuukka Toivonen:
>> Besides, format conversions _are not allowed_ in the kernel. They belong
>> into userspace.
> Well, there's no need to be dogmatic about it. In a basic sense any driver
> is performing a format conversion.

Well, it is possible that user applications get exactly the same bytes/bits
that the hardware generates, isn't that the case with most formats with 
common TV cards (bttv)? So I'm not sure why you say any driver does 
format conversions?

I find it rather confusing that some things are allowed in kernel while 
some not. Think about color balancing. This is image processing that I'm 
sure would be objected in the kernel, while it is mandatory to get 
useful colors from some cameras.

Something like picking up the image data from received USB packets and 
copying into image buffer, I don't consider that format conversion as long 
as no arithmetic operations are performed with the data.

And yeah, I do think that all of the arithmetic on the data should be done 
in userspace libraries, always. I'm just waiting until there is one common 
such library.

> Legally of course the license has been given and cannot unilaterally be
> revoked.

The GPL is an unilateral permission from author, and legally I don't know a 
rule which would prevent revocing it, because (usually) nobody has paid 
to obtain it. But IANAL, so I'll drop this subject now.

> But his name is on the driver and he gets the mails about it.

Well, the name could be prepended with a text explaining that Nemosoft does 
not maintain the code.
