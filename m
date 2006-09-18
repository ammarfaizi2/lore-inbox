Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWIRPlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWIRPlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWIRPlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:41:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:21541 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751792AbWIRPlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:41:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hKhF9IXplPqcLABXBgFfpHd1zxG+IArQ/0q96oTLao0qyviZAG5qD9t+fjf1d0MqJZfNX8l9JAucbPr+5YPBH7iyMIKrErnlRTlwsky48ctYdx3rYe7uaqRTCaAH2nBF3EjSLKMZvszqExxkeAWotWgvOGaj/h2qxbCTQ4s6hBY=
Message-ID: <d120d5000609180841v436f7a32l78b26fc72f48f92a@mail.gmail.com>
Date: Mon, 18 Sep 2006 11:41:06 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: Exporting array data in sysfs
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200609181718.35491.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609181359.31489.eike-kernel@sf-tec.de>
	 <200609181622.07681.eike-kernel@sf-tec.de>
	 <d120d5000609180759t42945f0bi496b3840818c218b@mail.gmail.com>
	 <200609181718.35491.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> Dmitry Torokhov wrote:
> > On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> >>Dmitry Torokhov wrote:
>
> >>> http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1155.html
>
> >> The limitation to 999 entries should go.
> >
> > It is not really a limitation but rather a safeguard. Do you really
> > expect to have arrays with that many attributes?
>
> At least I don't know how much they will be. If the user wants to do crazy
> things... :) I'm currently hacking on a store_n implementation, perhaps I'll
> be able to show some code tomorrow.
>

I do not think you shoudl allow user do crazy things. The memory is
kmalloced so there naturally a limit on number of attrinutes that can
be created. And I am not sure abot usefulness of resizing form
usespace.
Could you give me an example of a user who needs dynamic attribute arrays?

-- 
Dmitry
