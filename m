Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWFZN2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWFZN2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWFZN2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:28:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19607 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751191AbWFZN2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mVkJH3lA561gSAtLbxSidFw2n/pxonZkq5SsvObUeNci6KNUqg4XXNoGBXc2k+PfRc/Yb1DNV0lme49aWS0KhS/ufcXUQgvPvw6gGsDU23q05y/6ixeFGzAuzEnI+DRVWpr1S5xQciVne9UKHsL43rmjzNWA5pQy6tFsNL64pTg=
Message-ID: <d120d5000606260628j36e96b7bg861da96fcbe6bdb7@mail.gmail.com>
Date: Mon, 26 Jun 2006 09:28:13 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch] Fix input modalias sysfs attribute return size
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <1150930846.5549.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150930846.5549.24.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> When writing some udev rules using the input system's modalias
> attribute, udevinfo showed it as being ignored. Debugging revealed the
> 52 character string was over 128 bytes long according to udev (and hence
> ignored).
>
> The problem appears to be in the kernel where a max_t in input.c should
> really be a min_t.
>

Applied to my tree, Linus should pull shortly. Thank you Richard.

-- 
Dmitry
