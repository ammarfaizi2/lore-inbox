Return-Path: <linux-kernel-owner+w=401wt.eu-S965001AbWLTLTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWLTLTM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWLTLTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:19:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:14229 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965001AbWLTLTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:19:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iumQyakm1tA1R9ZyRZsS0IrMluBiCIA3xJhAQlLeq8KYBdiPZ3EuYZgvo5reF0uR6jXrHc/sy5Ig/3YEk6fDO690Wtz8yaZUt4D3UP49i7BrCK/86mYPpqYyFxkOWGWrXNcw0Wg7K6GvD1bs6D0qJtAyUZqL2TYFg8A1xCv95Eg=
Message-ID: <84144f020612200319s748457ccr11f527dd7bca4c96@mail.gmail.com>
Date: Wed, 20 Dec 2006 13:19:09 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "=?ISO-8859-1?Q?S=E9bastien_Dugu=E9?=" <sebastien.dugue@bull.net>
Subject: Re: Fix IPMI watchdog set_param_str() using kstrdup
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Jean Pierre Dion" <jean-pierre.dion@bull.net>
In-Reply-To: <20061220120544.36fdf518@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20061220120544.36fdf518@frecb000686>
X-Google-Sender-Auth: 4d8bd4c3ec30f218
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Sébastien Dugué <sebastien.dugue@bull.net> wrote:
>   set_param_str() cannot use kstrdup() to duplicate the parameter. That's
> fine when the driver is compiled as a module but it sure is not when
> built into the kernel as the kernel parameters are parsed before the
> kmalloc slabs are setup.

Aah. I wonder though, if we could defer parsing driver parameters
until kmalloc caches are up...
