Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVIFEWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVIFEWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVIFEWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:22:40 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:38881 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751313AbVIFEWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:22:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WB1WHEmhuvilTmKypyqBwA5s6y8HZzN0K0y61bUZX1+iNcGQhzlbI4iX/4gfucY+qD1goFgOFw9thn9Xi61CM+WpycW5uxqgKqQRZbGbuQZZHCowhQW+X23rHcrKiPe+2GLDhzNQ14KIzvZS8RNoHr45ABNmMngOQIhWiHc4yNY=
Message-ID: <29495f1d050905212261c63be4@mail.gmail.com>
Date: Mon, 5 Sep 2005 21:22:37 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: "mchehab@brturbo.com.br" <mchehab@brturbo.com.br>
Subject: Re: [PATCH 23/24] V4L: Include saa6588 compiler option and files / Fixes comments on tuner.h
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com, akpm@osdl.org
In-Reply-To: <431cb7f8.ifji6StBKz97ZtBQ%mchehab@brturbo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431cb7f8.ifji6StBKz97ZtBQ%mchehab@brturbo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, mchehab@brturbo.com.br <mchehab@brturbo.com.br> wrote:
>

Can this:

+static void saa6588_work(void *data)
+{
+	struct saa6588 *s = (struct saa6588 *)data;
+
+	saa6588_i2c_poll(s);
+	mod_timer(&s->timer, jiffies + HZ / 50);	/* 20 msec */
+}
+

be:

mod_timer(&s->timer, jiffies + msecs_to_jiffies(20));

?

Thanks,
Nish
