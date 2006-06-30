Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWF3DsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWF3DsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 23:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWF3DsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 23:48:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:5312 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750798AbWF3DsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 23:48:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tkVer4osMuQ4KYmwoOWMrxcRQ68e5/LujO3Vzf+u7KGhGO9Eo/bdVmo1UjszcRp45+VZCU1ooCp+iuawnKe0hxixRUkHDeE0U0oLlkc3bAM8LKyLr/CcIwdIpisNGobU+mo5aCQSxyDmcutDoj30q3QwXrLS1HcD2iq4LQM9A2I=
Message-ID: <a36005b50606292048y2436282cv909a264b4fb7b909@mail.gmail.com>
Date: Thu, 29 Jun 2006 20:48:17 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: make PROT_WRITE imply PROT_READ
Cc: "Pavel Machek" <pavel@ucw.cz>, "Jason Baron" <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1151568930.3122.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
	 <1151568930.3122.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Arjan van de Ven <arjan@infradead.org> wrote:
> the thing is.. you can say EXACTLY the same about PROT_EXEC.. not all
> processors support enforcing that.. so should we just always imply
> PROT_EXEC as well?

There is a fundamental difference: not setting PROT_EXEC has no
negative side effects.  You might be able to execute code and it just
works.

With PROT_READ this is not the case, there _are_ side effects which are visible.
