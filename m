Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWAVTYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWAVTYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWAVTYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:24:48 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:16059 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750914AbWAVTYs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lreat+RydjD8cbl0FWaZhAVttpkX45lhFB8il8EQ6rTMSK9Bkcr8IxypWSUiU9ByUYcsU9gYSnFRTHzLIFobpWt5R5aqiC5iSE7hBtePIECG93EBKg8UahyvzadZVSFjjwbY5fpByZdr6cDylgPsZ4k4td33FvnESE81WgYKahg=
Message-ID: <787b0d920601221117l78a92fd1udc8601068dbde42c@mail.gmail.com>
Date: Sun, 22 Jan 2006 14:17:44 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] add /proc/*/pmap files
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1137940577.3328.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
	 <1137940577.3328.14.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2006-01-22 at 04:50 -0500, Albert Cahalan wrote:
> > This adds a few things needed by the pmap command.
> > They show up in /proc/*/pmap files.
>
>
> also since this shows filenames and such, could you make the permissions
> of the pmap file be 0400 ? (yes I know some others in the same dir
> aren't 0400 yet, but I hope that that can be changed in the future,
> adding more of these should be avoided for information-leak/exposure
> reasons)

I thought it was the addresses you'd object to.

I was thinking I'd follow up with a patch to make things
a bit more logical as far as info exposure goes. It makes
no sense to have the /proc/*/exe link fail a readlink()
when one can reliably guess that data from elsewhere.

I notice that Fedora Core 4 shipped with /proc/*/smaps
files that were readable, but /proc/*/maps files that were
not readable. (at least, a recent kernel update did)

As of now, I'm keeping mainstream kernel policy as is.
