Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbUL3BTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbUL3BTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUL3BTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:19:18 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:61338 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261494AbUL3BTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:19:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gGu9gyxmQzCW8bO68WkQpAB8WE8bBQO+u7YHj5le5eDFlc+3jrS0suBnm/vrMHMsmoG8Ql7fuyrvVi4IBsuk4VvSgvPK7SDQma9zdQg90qaBtq9U/X+D+wzk6oS+S5C6pMTBzObG0IFbwMTgwNHYxnhBDFErRb3Ap41aSG1MwbE=
Message-ID: <a36005b50412291719257882b6@mail.gmail.com>
Date: Wed, 29 Dec 2004 17:19:16 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: Re: [PATCH] SATA support for Intel ICH7 - 2.6.10
Cc: Jeff Garzik <jgarzik@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F502AE9F2B@orsmsx410>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <26CEE2C804D7BE47BC4686CDE863D0F502AE9F2B@orsmsx410>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 16:13:41 -0800, Gaston, Jason D
<jason.d.gaston@intel.com> wrote:
>         } else {
> -               WARN_ON(ich != 6);
> +               WARN_ON((ich != 6) || (ich != 7));

This cannot be right.  Every number is either != 6 or != 7.  You want &&.
