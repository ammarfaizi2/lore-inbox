Return-Path: <linux-kernel-owner+w=401wt.eu-S1751668AbWLNXQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWLNXQH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWLNXQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:16:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:5060 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbWLNXQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:16:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FWjNGvG/qbK7LVqgthm9vlR8kGxYVD1LXbL812i2PCab5qIEHHigpaSQ2CLMSbbG7yASc/uD+3cfLdQrXw5Dm1NETHp8RPM9maYgE226gHClAg4HI6nEE2836M+twvsU8vdkbdCVyryECPHbqA9iyElMzkOUmg6B9WlKXuNKA0Q=
Message-ID: <653402b90612141516w46e4a623u21ba34f9664f392c@mail.gmail.com>
Date: Fri, 15 Dec 2006 00:16:01 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
>
>   there are numerous places throughout the source tree that apparently
> calculate the size of an array using the construct
> "sizeof(fubar)/sizeof(fubar[0])". see for yourself:
>
>   $ grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" *
>
> but we already have, from "include/linux/kernel.h":
>
>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

Maybe *(x) instead of (x)[0]?

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
