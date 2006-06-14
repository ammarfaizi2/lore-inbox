Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWFNRtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFNRtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWFNRtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:49:25 -0400
Received: from smtp-out.google.com ([216.239.45.12]:9957 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932235AbWFNRtY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:49:24 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=V8O9HZlHc+JK3Y3L8I6k8Q8+Cb/enT1I7V+cTzLpBsYSP4KUrnXr0fsadk0vVlpOE
	QUCvmbm88k+svuoDyzlYw==
Message-ID: <44904C08.6020307@google.com>
Date: Wed, 14 Jun 2006 10:48:56 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: bidulock@openss7.org, Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060614133022.GU11863@sunbeam.de.gnumonks.org>
In-Reply-To: <20060614133022.GU11863@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald,

You wrote:
> On Tue, Jun 13, 2006 at 02:12:41PM -0700, I wrote:
> 
>>This has the makings of a nice stable internal kernel api.  Why do we want
>>to provide this nice stable internal api to proprietary modules?
> 
> because there is IMHO legally nothing we can do about it anyway.

Speaking as a former member of a "grey market" binary module vendor that
came in from the cold I can assure you that the distinction between EXPORT
and EXPORT_GPL _is_ meaningful.  That tainted flag makes it extremely
difficult to do deals with mainstream Linux companies and there is always
the fear that it will turn into a legal problem.  The latter bit tends to
make venture capitalists nervous.

That said, the EXPORT_GPL issue is not about black and white legal issues,
it is about gentle encouragement.  In this case we are offering a clumsy,
on-the-metal, guaranteed-to-change-and-make-you-edit-code interface to
non-GPL-compatible modules and a decent, stable (in the deserves to live
sense) interface for the pure of heart.  Gentle encouragement at exactly
the right level.

Did we settle the question of whether these particular exports should be
EXPORT_SYMBOL_GPL?

Regards,

Daniel
