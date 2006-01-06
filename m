Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965349AbWAFXML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbWAFXML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbWAFXMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:12:10 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:31438 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965349AbWAFXMJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:12:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cmpHSNpKj7jA3xH6TElvRgLwesp1pSBkrH85pnV6YBAeeygF3QP+L2dMNuaOUwcHPkLLaGzLw5x40F4c7jcj6qHx+rdTYi2ZNexxXKrjg7Fow4UfaDiGJbpbcbYMvqOTyeUqxtx+xWFCb0kmxWP8iXnoHoKQ/AbMmFq+YU66WBc=
Message-ID: <d120d5000601061512s1b282ee5o259ec3d6e9a730c2@mail.gmail.com>
Date: Fri, 6 Jan 2006 18:12:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2/4] fix input layer f_ops abuse
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1136584073.2940.95.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
	 <1136584073.2940.95.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Arjan van de Ven <arjan@infradead.org> wrote:
> From: Arjan van de Ven <arjan@infradead.org>
>
> The input layer has an assignment to a live ->fops, just after creating the
> fops as a duplicate of another one. Just move this assignment a few lines up to avoid
> the race and the assignment to a live fops
>

I do not understand how it will fix the "race", there is still a split
second between "entry" having default fops and modified one. I'd
prefer you fix the comment to reflect that the only change is because
fops is now constant.

--
Dmitry
